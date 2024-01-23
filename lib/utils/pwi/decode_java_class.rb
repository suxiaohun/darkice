path_prefix = "/Users/crystal/workspace/pwi/pwadmin/WEB-INF/classes"
paths = ["com", "protocol"]

dest_path_prefix = "/Users/crystal/workspace/pwi/pwadmincode/src"

paths.each do |path|
  # puts path
  Dir.chdir(path_prefix) do
    Dir.glob("#{path}/**/*.class") do |file|
      file_dir = File.dirname(file)
      # puts file_dir
      puts file
      dest_dir = "#{dest_path_prefix}/#{file_dir}"
      dest_file_name = "#{dest_path_prefix}/#{file.split(".")[0]}.java"

      `mkdir -p #{dest_dir}`
      `java -jar  cfr-0.152.jar #{file}  --hideutf false > #{dest_file_name}`
    end
  end

end









