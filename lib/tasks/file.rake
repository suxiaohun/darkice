namespace :file do
  desc "move subdir files to one dir"
  task move: :environment do
    dir_path = ENV["path"]
    unless dir_path.present?
      puts "请指定路径:  rake file:move path=/home/xiaopang/xxx".red
      next
    end
    begin
      FileUtils.cd(dir_path) do
        files = Dir.glob("**/*.jpg")

        names1 = []
        names2 = []

        count = 0
        files.each do |file_name|
          if file_name.include? "demask"
            names1 << file_name
          else
            names2 << file_name
          end
        end

        dirname = File.dirname("../backup/demask")
        FileUtils.mkdir_p(dirname)
        names1.each do |file_name|
          FileUtils.cp(file_name, dirname)
        end
        puts "-----------#{count}---"
      end
    end
  end

  desc "rename files in the dir"
  task rename: :environment do
    dir_path = ENV["path"]
    name_length = ENV["len"].to_i
    unless dir_path.present?
      puts "请指定路径:  rake file:rename path=/home/crystal/xxx len=4".red
      next
    end
    begin
      FileUtils.cd(dir_path) do
        files = Dir.glob("*.*")
        name_length = files.size.to_s.size if name_length == 0
        count = 0
        files.each do |old_name|
          count += 1
          ext = old_name.split(".")[-1]
          new_name = "#{count}".rjust(name_length, "0") + "." + ext
          File.rename(old_name, new_name)
          puts new_name.green
        end
        puts "-----------#{count}---"
      end
    end
  end

end