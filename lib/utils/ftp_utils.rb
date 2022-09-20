require 'net/ftp'

local_path = "fenghuo"
ftp = Net::FTP.open('10.4.243.51', 'ftpuser', 'ftpuser')
# files = ftp.chdir('pub/lang/ruby/contrib')
entries = ftp.list('cylon_files')
entries.each_with_index do |entry, i|
  dir = entry.split(" ")[-1]
  if dir =~ /20220811\d{4}/
    files = ftp.list("cylon_files/#{dir}")
    files.each_with_index do |file, j|
      file = file.split(" ")[-1]
      remote_path = "cylon_files/#{dir}/#{file}"
      puts "...#{i}...#{dir}...#{j}...#{file}"
      ftp.getbinaryfile(remote_path,"#{local_path}/#{file}", 1024)
    end
  end
end


