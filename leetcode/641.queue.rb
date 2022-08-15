class MyCircularDeque
  attr_accessor :size, :queue

=begin
    :type k: Integer
=end
  def initialize(k)
    @size = k
    @queue = []
  end

=begin
    :type value: Integer
    :rtype: Boolean
=end
  def insert_front(value)
    if @queue.size < @size
      @queue.unshift(value)
      true
    else
      false
    end
  end

=begin
    :type value: Integer
    :rtype: Boolean
=end
  def insert_last(value)
    if @queue.size < @size
      @queue.push(value)
      true
    else
      false
    end
  end

=begin
    :rtype: Boolean
=end
  def delete_front()
    if @queue.size > 0
      @queue.shift
      return true
    end
    false
  end

=begin
    :rtype: Boolean
=end
  def delete_last()
    if @queue.size > 0
      @queue.pop
      return true
    end
    false
  end

=begin
    :rtype: Integer
=end
  def get_front()
    if @queue.size > 0
      return @queue[0]
    end
    -1
  end

=begin
    :rtype: Integer
=end
  def get_rear()
    if @queue.size > 0
      return @queue[-1]
    end
    -1
  end

=begin
    :rtype: Boolean
=end
  def is_empty()
    @queue.size == 0
  end

=begin
    :rtype: Boolean
=end
  def is_full()
    @queue.size == @size
  end

end

# Your MyCircularDeque object will be instantiated and called as such:
# obj = MyCircularDeque.new(k)
# param_1 = obj.insert_front(value)
# param_2 = obj.insert_last(value)
# param_3 = obj.delete_front()
# param_4 = obj.delete_last()
# param_5 = obj.get_front()
# param_6 = obj.get_rear()
# param_7 = obj.is_empty()
# param_8 = obj.is_full()