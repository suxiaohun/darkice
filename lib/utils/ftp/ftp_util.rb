require 'net/ftp'

def delete
  date = "20220811"
  ftp = Net::FTP.open('10.4.243.51', 'ftpuser', 'ftpuser')
  ftp.passive = true
  entries = ftp.list('cylon_files')
  entries.each_with_index do |entry, i|
    dir = entry.split(" ")[-1]
    if dir =~ /#{date}\d{4}/
      files = ftp.list("cylon_files/#{dir}")
      files.each_with_index do |file, j|
        file = file.split(" ")[-1]
        remote_path = "cylon_files/#{dir}/#{file}"
        puts "...#{i}...#{dir}...#{j}...#{file}"
        ftp.delete(remote_path)
      end
      puts "======delete dir: #{i}...#{dir}"
      ftp.delete(dir)
    end
  end
end

def download
  date = "20220811"
  local_path = "fenghuo"
  ftp = Net::FTP.open('10.4.243.51', 'ftpuser', 'ftpuser')
  ftp.passive = true
  # files = ftp.chdir('pub/lang/ruby/contrib')
  entries = ftp.list('cylon_files')
  entries.each_with_index do |entry, i|
    dir = entry.split(" ")[-1]
    if dir =~ /#{date}\d{4}/
      files = ftp.list("cylon_files/#{dir}")
      files.each_with_index do |file, j|
        file = file.split(" ")[-1]
        remote_path = "cylon_files/#{dir}/#{file}"
        puts "...#{i}...#{dir}...#{j}...#{file}"
        ftp.getbinaryfile(remote_path, "#{local_path}/#{file}", 1024)
      end
    end
  end
end

def total_counter
  date = "20220920"
  # ftp = Net::FTP.open('10.4.243.51', 'ftpuser', 'ftpuser')
  ftp = Net::FTP.open('10.111.33.213', 'dummyUser', 'dummyPassword')
  ftp.passive = true
  entries = ftp.list('cylon_files')
  count = 0
  entries.each_with_index do |entry, i|
    dir = entry.split(" ")[-1]
    if dir =~ /#{date}\d{4}/
      files = ftp.list("cylon_files/#{dir}")
      count += files.size
      puts files.size
    end
  end
  puts "...#{date}..total_count: #{count}"
end

download
# total_counter

