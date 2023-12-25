require 'uri'
require 'net/http'
require 'pry'
require 'json'
require 'time'
require 'fileutils'
require 'nokogiri'

URL = "https://www.pwdatabase.com/cn/mob"

wrong_ids = []
File.open("wrong_ids", "a+") do |io|
  io.each_line do |line|
    wrong_ids << line.chomp!
  end
end

ok_ids = []
File.open("ok_ids", "a+") do |io|
  io.each_line do |line|
    ok_ids << line.chomp!
  end
end

puts wrong_ids.count

# File.open("mobs", "w") do |io|
#   io.puts "ID\tName\tLife\tAccuracy\tEvasion\tPhysical_Attack\tMagic_Attack\tPhysical_Defense\tMagic_Defense\tSpeed"
# end


15000.times do |i|
  mob_id = "#{i + 1}"
  next if wrong_ids.include? "#{mob_id}"
  next if ok_ids.include? "#{mob_id}"
  puts mob_id
  uri = URI("#{URL}/#{i + 1}")
  res = Net::HTTP.get_response(uri)
  if res.is_a?(Net::HTTPSuccess)
    div_with_id_test = Nokogiri::HTML(res.body).css("#content").first
    # 获取 div 的内容
    content_of_div = div_with_id_test.inner_html

    next if content_of_div.nil?
    # 解析包含 table 的内容
    table = Nokogiri::HTML(content_of_div).css('table').first

    # 遍历每一行 tr
    if table.nil?
      File.open("wrong_ids", "a+") do |io|
        io.puts mob_id
      end
      next
    end
    mob_name=""
    table.css('tr').each do |row|
      row.css('th').each do |cell|
        puts cell.text
        mob_name = cell.text
        next
      end
      # 跳过td0，只获取第二列属性

      next unless row.css('td')
      next unless row.css('td').count > 1
      ps = row.css('td')[1].css("p")

      life = ps[0].text
      accuracy=ps[1].text
      evasion=ps[2].text
      physical_attack=ps[3].text
      magic_attack=ps[4].text
      physical_defense=ps[5].text
      magic_defense="#{ps[6].text},#{ps[7].text},#{ps[8].text},#{ps[9].text},#{ps[10].text}"
      speed = "#{ps[11].text},#{ps[12].text},#{ps[13].text},#{ps[14].text},"
      row_info = "#{mob_id}\t#{mob_name}\t#{life}\t#{accuracy}\t#{evasion}\t#{physical_attack}\t#{magic_attack}\t#{physical_defense}\t#{magic_defense}\t#{speed}".gsub(" ","")
      puts row_info
      File.open("mobs","a+") do |io|
        io.puts row_info
      end
      File.open("ok_ids","a+") do |io|
        io.puts mob_id
      end
    end
  end
end
