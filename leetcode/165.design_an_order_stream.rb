class OrderedStream

  attr_accessor :queue, :size, :ptr
=begin
    :type n: Integer
=end
  def initialize(n)
    @queue = []
    @size = n
    @ptr = 1
  end

=begin
    :type id_key: Integer
    :type value: String
    :rtype: String[]
=end
  def insert(id_key, value)
    @queue[id_key] = value
    arr = []
    if @queue[@ptr]
      while @queue[@ptr]
        arr << @queue[@ptr]
        @ptr += 1
      end
    end
    arr
  end
end

# Your OrderedStream object will be instantiated and called as such:
# obj = OrderedStream.new(n)
# param_1 = obj.insert(id_key, value)