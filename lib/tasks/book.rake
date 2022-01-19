require 'optparse'
namespace :book do
  def get_pre_content(path)
    pre_content = ''
    begin
      File.open(path) do |io|
        10.times do
          _temp_content = io.gets
          if _temp_content.size > 300
            _temp_content = _temp_content[0, 300]
            break
          end
          pre_content += _temp_content
        end
      end
      puts "....init book preview content: #{path}".green
    rescue => e
      puts "#{e.message}".red
    end
    pre_content
  end

  def init_book_list
    path_prefix = "lib/utils/books/"
    FileUtils.cd(path_prefix) do
      FileUtils.rm Dir.glob('*.yml')
    end
    Dir.glob("public/books/*") do |origin_path|
      category = origin_path.split("/")[-1]
      path = path_prefix + category + '.yml'

      unless File.exist? path
        File.open(path, 'w') do |io|
          FileUtils.cd(origin_path) do
            files = Dir.glob("*.[tT][xX][tT]")
            files.each do |file_name|
              _zh_name = file_name.split('.')[0]
              _en_name = Pinyin.t(_zh_name, splitter: '')
              io.puts _en_name + ':'
              io.puts "  name: " + _zh_name
            end
          end
        end
      end

      puts "=====path: #{path}"

      books = YAML.load_file(path).deep_symbolize_keys rescue {}
      books.each do |_, v|
        book = Book.new
        book.name = v[:name]
        book.display_name = v[:name]
        book.uuid = Digest::MD5.hexdigest(v[:name])
        book.author = Author.find_or_create_by!(name: v[:author] || '未知')
        book.category = Category.find_or_create_by!(name: category)
        book.tag = v[:tag]
        book.path = origin_path + '/' + book.name + '.txt'
        book.save!
        puts "....create book: #{v[:name]}".green
      end
    end
  end

  desc "init the books"
  task init: :environment do
    es_flag = ENV["es"]
    if es_flag.present?
      system "rake elasticsearch:create_index class=book"
    end

    # 如果数据存在，同步数据到es
    #system "rake elasticsearch:rake elasticsearch:sync_data  class=book"

    Redis.new(REDIS_CONFIG).flushall
    Book.destroy_all
    Category.destroy_all

    init_book_list

    Book.all.each do |book|
      book.pre_content = get_pre_content(book.path)
      book.save!
    end

  end

  desc "use number as the new name of the book"
  task rename: :environment do
    dir_path = ENV["path"]
    unless dir_path.present?
      puts "请指定路径:  rake book:encode path=/home/crystal/xxx".red
      next
    end
    begin
      FileUtils.cd(dir_path) do
        files = Dir.glob("*.[tT][xX][tT]")
        name_length = files.size.to_s.size
        count = 0
        files.each do |old_name|
          count += 1
          new_name = "#{count}".rjust(name_length, "0") + ".txt"
          File.rename(old_name, new_name)
          puts new_name.green
        end
        puts "-----------#{count}---"
      end
    end
  end

  desc "book format"
  task format: :environment do
    dir_path = ENV["path"]
    unless dir_path.present?
      puts "请指定路径:  rake book:encode path=/home/crystal/xxx".red
      next
    end

    begin
      FileUtils.cd(dir_path) do
        FileUtils.rm_rf(BOOK_BACKUP_DIR)
        files = Dir.glob("**/*.[tT][xX][tT]")
        files.each_with_index do |old_name, i|
          next if File.zero?(old_name)

          new_name = "#{BOOK_BACKUP_DIR}/#{old_name.gsub(" ", "")[0..-4]}txt"
          create_backup_dir(new_name)

          puts "------#{i + 1}---#{old_name}---#{new_name}"
          File.open(old_name) do |input|
            content = convert_utf8(input.read)
            File.open(new_name, 'w') do |output|
              output.write(content)
            end
          end
        end
      end
    end
  end

  desc "concat files to one file"
  task concat: :environment do
    dir_path = ENV["path"]
    unless dir_path.present?
      puts "请指定路径:  rake book:concat path=/home/xiaopang/xxx".red
      next
    end
    begin
      FileUtils.cd(dir_path) do
        puts "current dir: #{FileUtils.pwd}".green
        FileUtils.rm_rf('backup')
        sleep 2
        FileUtils.mkdir_p('backup')
        file_name = '1.txt'
        begin
          io = File.open("backup/#{file_name}", 'w')
          concat_files(io)
        rescue => e
          puts e.message.red
        ensure
          io.close
        end
      end
    rescue Errno::ENOENT
      puts "无效的路径: #{ARGV[1]}".red
    rescue => e
      puts e.message.red
    end
  end

  # 将目录下的所有txt文件，按名字排序后，合并成一个文件
  def concat_files(io)
    files = Dir.glob("*.[tT][xX][tT]").sort
    files.each do |file_name|
      puts file_name.green
      File.open(file_name) do |input|
        io.puts input.read
      end
    end
  end

  # 验证转码后的文件是否正确转成了utf8
  def verify
    count = 0
    error_valid_files = []
    Dir.glob(["backup/**/*.txt", "backup/**/*.TXT"]).each do |file_name|
      count += 1
      File.open(file_name) do |io|
        str = ''
        10.times do
          str += (io.gets || '')
        end
        str = str.gsub(/(\s|[-=━])+/, "")[0, 30]

        if str.to_s =~ /(\p{Han}|[A-Za-z0-9])+/
          puts "----#{count.to_s}---验证通过-----------#{file_name}----#{str}------------".green
        else
          error_msg = "----#{count.to_s}---验证失败-----------#{file_name}----#{str}------------".red
          error_valid_files << error_msg
          puts error_msg
        end
      end
    end
    error_valid_files.each(&method(:puts))
    puts "........共计#{count}本"
  end

  def create_backup_dir(file_name)
    dirname = File.dirname(file_name)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  def convert_utf8(content)
    return content if content.force_encoding('UTF-8').valid_encoding?
    if content.force_encoding('GB18030').valid_encoding?
      content.encode('UTF-8')
    else
      raise "unsupported encode, check the book"
    end
  end

end
