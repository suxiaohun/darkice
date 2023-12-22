class BooksController < ApplicationController
  before_action :set_book, only: [:show, :page_size, :next, :goto, :edit, :update, :destroy]

  def index
    c = Category.find_by(name: "1024")
    ids = Book.where.not(category_id: c.id).pluck(:id)
    @books = Book.find(ids.sample(10))
  end

  def category
    if params[:id] == 'all'
      @books = Book.includes(:author).all
    else
      c = Category.find_by(id: params[:id])
      if c && c.name == "1024" && cookies[:auth_code] != BOOK_AUTH_CODE
        redirect_to action: "auth"
      end
      @books = Book.includes(:author).where(category_id: params[:id])
    end
  end

  def auth
    if request.post?
      if params[:auth_code] == BOOK_AUTH_CODE
        cookies.permanent[:auth_code] = BOOK_AUTH_CODE
        redirect_to action: "index"
      end
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @data = {}
    @data[:id] = params[:id]
    File.open(@book.path) do |io|
      io.pos = cookies[book_reading_pos_key].to_i
      @data[:pre_pos] = io.pos
      @data[:curr_pos] = io.pos
      @data[:lines] = io.first(get_page_size)
      @data[:lines][0] = @data[:lines][0].encode("UTF-8", invalid: :replace, replace: "")
      @data[:next_pos] = io.pos
    end
    @data[:rate] = range_rate(@data[:curr_pos])
  end

  def page_size
    page_size = params[:page_size].to_i

    unless page_size >= 5 && page_size <= 100
      page_size = BOOK_DEFAULT_LINES
    end
    cookies.permanent[:page_size] = page_size
    current_pos = params[:current_pos].to_i

    @data = {}
    @data[:id] = params[:id]
    File.open(@book.path) do |io|
      io.pos = current_pos.to_i
      @data[:curr_pos] = current_pos
      @data[:lines] = io.first(get_page_size)
      @data[:next_pos] = io.pos
    end
    @data[:rate] = range_rate(@data[:curr_pos])
  end

  def goto
    process = params[:process].to_i
    unless process >= 0 && process <= 100
      process = 0
    end

    @data = {}
    @data[:id] = params[:id]
    File.open(@book.path) do |io|
      io.pos = book_total_pos * process / 100
      cookies.permanent[book_reading_pos_key] = io.pos
      @data[:curr_pos] = io.pos
      @data[:lines] = io.first(get_page_size)
      @data[:lines][0] = @data[:lines][0].encode("UTF-8", invalid: :replace, replace: "") # 文件指针切分可能会把一个完整字符拆分，减少2个字符即可(一个汉字占三个字节)
      @data[:next_pos] = io.pos
    end
    save_reading_history
  end

  def next
    @data = {}
    @data[:id] = params[:id]
    File.open(@book.path) do |io|
      io.pos = (params[:next_pos].to_i || 0)
      cookies.permanent[book_reading_pos_key] = io.pos
      @data[:curr_pos] = io.pos
      @data[:lines] = io.first(get_page_size)
      @data[:next_pos] = io.pos
    end
    @data[:rate] = range_rate(@data[:curr_pos])
    save_reading_history
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
    #render layout: 'es'
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
    (curr_pos * 100.0 / book_total_pos.to_i).round(2)
  end

  def save_reading_history
    cookies.permanent[:reading_history] = cookies[:reading_history] || "{}"
    _h = JSON.parse cookies[:reading_history]
    _h.delete(@book.id.to_s)
    _h[@book.id.to_s] = @book.name
    _h.shift if _h.size > 5
    cookies.permanent[:reading_history] = _h.to_json
  end
end
