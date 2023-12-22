# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def swap_pairs(head)
  return ListNode.new(nil) if head.nil?
  return head if head.next.nil?
  @_hash = {}
  @count = 0
  traversal(head)
  @_hash.each do |k, _|
    if k % 2 == 0
      @_hash[k], @_hash[k - 1] = @_hash[k - 1], @_hash[k]
    end
  end
  @_hash.each do |k, v|
    head = @_hash[k] if k == 1
    @_hash[k].next = @_hash[k + 1]
  end
  head
end

def traversal(head)
  return if head.nil?
  @count += 1
  @_hash[@count] = head
  traversal(head.next)
end