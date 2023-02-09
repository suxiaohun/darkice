require 'digest/md5'

def gen_bcp
  File.open("test.bcp", "w") do |io|

    Dir.glob("*") do |name|
      next if name == "test.bcp"
      puts "---#{name}----"
      ts = (Time.now.to_f * 1000000000).to_i
      size = File.size(name)
      md5 = Digest::MD5.hexdigest(File.read(name))
      row = "#{ts}\t#{name}\t#{size}\t#{md5}"

      io.puts row
    end
  end
end

gen_bcp