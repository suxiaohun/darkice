# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @param {Integer} n
# @return {ListNode}
def remove_nth_from_end(head, n)
  @count = 0
  @hash = {}
  list(head)
  index = @count - n
  if (index - 1) < 0
    @hash[index].next
  else
    @hash[index - 1].next = @hash[index].next
    head
  end
end

def list(head)
  return if head.nil?
  @hash[@count] = head
  @count += 1
  list(head.next)
end