
def upload(start,size=100)
  start_time = Time.now
  size.times do |i|
    name = "#{i+start}.jpg"
    url = "curl -F \"filename=@fbb3.jpg\" http://172.20.25.15:31998/buckets/cylon-internal-ingress/2022-10-09/#{name}"

    system url
    puts i
  end
  cost = Time.now - start_time
  puts "====cost: #{cost}"
end


total_start = Time.now

threads = []

t_count = 50
t_cap = 10000

t_count.times do |i|
  threads << Thread.new(i*t_cap,t_cap) {|start,size| upload(start,size) }
end

threads.each(&:join)

total_cost = Time.now - total_start

puts "==========total cost: #{total_cost}"