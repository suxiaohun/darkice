class BooksController < ApplicationController
  before_action :set_book, only: [:show, :page_size, :next, :prev, :goto, :edit, :update, :destroy]
  layout 'books'

  def index
    c = Category.find_by(name: "1024")
    if c.nil?
      return @books = []
    end
    ids = Book.where.not(category_id: c.id).pluck(:id)
    @books = Book.find(ids.sample(10))
  end

  def category
    @books = Book.includes(:author).where(category_id: params[:id])
    @category = Category.find(params[:id])
    respond_to do |format|
      format.turbo_stream
    end
  end

  def auth
    if request.post?
      @check = false
      @notice = "invalid password"
      if params[:auth_code] == BOOK_AUTH_CODE
        cookies.permanent[:auth_code] = BOOK_AUTH_CODE
        id = Category.find_by_name("1024").id
        @books = Book.includes(:author).where(category_id: id)
        @check = true
        @notice = ""
      end
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @data = {}
    @data[:id] = params[:id]
    start_pos = cookies[book_reading_pos_key].to_i
    lines,end_pos = get_lines(start_pos)
    @data[:neof] = true if end_pos < @book.total_size
    @data[:lines] = lines
    @data[:start_pos] = start_pos
    @data[:end_pos] = end_pos
    # binding.pry

    @data[:rate] = range_rate(@data[:end_pos])
  end

  def page_size
    page_size = params[:page_size].to_i

    unless page_size >= 5 && page_size <= 100
      page_size = BOOK_DEFAULT_LINES
    end
    cookies.permanent[:page_size] = page_size
    start_pos = cookies[book_reading_pos_key].to_i

    @data = {}
    @data[:id] = params[:id]

    lines,end_pos = get_lines(start_pos)
    @data[:neof] = true if end_pos < @book.total_size
    @data[:lines] = lines
    @data[:start_pos] = start_pos
    @data[:end_pos] = end_pos


    @data[:rate] = range_rate(@data[:end_pos])
    respond_to do |format|
      format.turbo_stream
    end
  end

  def goto
    process = params[:process].to_i
    unless process >= 0 && process <= 100
      process = 0
    end

    @data = {}
    @data[:id] = params[:id]

    if process == 100
      lines,start_pos = get_reverse_lines(@book.total_size)
      @data[:start_pos] = start_pos
      @data[:end_pos] = @book.total_size
    else
      start_pos = (@book.total_size * process / 100).round
      lines,end_pos,start_pos = get_lines(start_pos,1)
      @data[:start_pos] = start_pos
      @data[:end_pos] = end_pos
      @data[:neof] = true
    end
    @data[:lines] = lines
    cookies.permanent[book_reading_pos_key] = start_pos
    puts "cache pos: #{start_pos}"
    save_reading_history
    respond_to do |format|
      format.turbo_stream
    end
  end

  def next
    @data = {}
    @data[:id] = params[:id]
    start_pos = params[:start_pos].to_i || 0
    lines,end_pos = get_lines(start_pos)

    cookies.permanent[book_reading_pos_key] = start_pos
    @data[:start_pos] = start_pos
    @data[:lines] = lines
    @data[:end_pos] = end_pos
    @data[:neof] = true if end_pos < @book.total_size

    @data[:rate] = range_rate(@data[:end_pos])
    save_reading_history
    respond_to do |format|
      format.turbo_stream
    end
  end

  def prev
    @data = {}
    @data[:id] = params[:id]
    end_pos = params[:start_pos].to_i || 0

    lines, start_pos = get_reverse_lines(end_pos)

    cookies.permanent[book_reading_pos_key] = start_pos
    @data[:neof] = true
    @data[:start_pos] = start_pos
    @data[:lines] = lines
    @data[:end_pos] = end_pos

    @data[:rate] = range_rate(@data[:end_pos])
    save_reading_history
    respond_to do |format|
      format.turbo_stream
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def es
    @books = Book.all.page(params[:page] || 1)
    # render layout: 'es'
  end

  def es_search
    es_query = {}

    es_query[:from] = 0
    es_query[:size] = 1000 # es默认是10条
    es_query[:query] = { "match_all": {} }

    if params[:name].present?
      es_query[:query] = {
        wildcard: {
          name: '*' + params[:name] + "*"
        }
      }
    end

    es_query[:sort] = [
      { "created_at": { "order": "desc" } }
    ]

    logs = Book.__elasticsearch__.search(es_query)
    @books = logs.records.page(params[:page] || 1)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.fetch(:book, {})
  end

  def get_page_size
    page_size = cookies[:page_size] || BOOK_DEFAULT_LINES
    page_size.to_i
  end

  def book_total_pos
    total_pos = BOOK_REDIS.get(book_total_pos_key)
    return total_pos.to_i if total_pos

    File.open(@book.path) do |io|
      BOOK_REDIS.set(book_total_pos_key, io.size)
    end
    BOOK_REDIS.get(book_total_pos_key).to_i
  end

  def book_total_pos_key
    "#{@book.uuid}_total_pos"
  end

  def book_reading_pos_key
    "#{@book.uuid}_reading_pos"
  end

  def range_rate(curr_pos)
    (curr_pos * 100.0 / @book.total_size).round(2)
  end

  def save_reading_history
    cookies.permanent[:reading_history] = cookies[:reading_history] || "{}"
    _h = JSON.parse cookies[:reading_history]
    _h.delete(@book.id.to_s)
    _h[@book.id.to_s] = @book.name
    _h.shift if _h.size > 5
    cookies.permanent[:reading_history] = _h.to_json
  end

  def get_lines(start_pos,extra=0)
    extra = 0 if start_pos == 0 # 只有range条转换成小数时，会出现字符截断的问题
    num_lines = get_page_size
    lines = []
    end_pos = start_pos
    File.open(@book.path, "r") do |io|
      io.pos = start_pos
      lines = io.first(num_lines + extra)
       if lines.size > num_lines
         temp = lines.shift
         start_pos = start_pos+temp.bytesize
       end

      end_pos = io.pos
    end
    return lines,end_pos,start_pos
  end

  def get_reverse_lines(end_pos)
    num_lines = get_page_size
    lines = []
    start_pos = end_pos
    File.open(@book.path, 'r') do |io|
      io.pos = end_pos
      io.seek(0, IO::SEEK_CUR)

      while lines.size < num_lines && io.pos > 0
        puts "------old pos:  #{io.pos}"
        io.seek(-[io.pos, 1024].min, IO::SEEK_CUR)

        maxlen = end_pos - io.pos
        out_string = "".force_encoding("UTF-8")
        io.read(maxlen, out_string)
        new_lines = out_string.lines
        # binding.pry
        if new_lines.size > num_lines
          puts "break lines; #{new_lines.size}"
          lines = new_lines[-num_lines..-1]
          pos = lines.sum { |x| x.bytesize }
          puts "break pos:  #{pos}"
          io.seek(-pos, IO::SEEK_CUR) # 重置指针
        else
          lines = new_lines
          puts "buff lines:  #{new_lines.size}"
          io.seek(-maxlen, IO::SEEK_CUR) # 重置指针
        end
        puts "------new pos:  #{io.pos}"
      end
      start_pos = io.pos
    end
    return lines, start_pos
  end

end
