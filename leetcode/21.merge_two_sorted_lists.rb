# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} list1
# @param {ListNode} list2
# @return {ListNode}
def merge_two_lists(list1, list2)
  return if list1.nil? && list2.nil?
  if list1.nil?
    return ListNode.new(list2.val, list2.next)
  end
  if list2.nil?
    return ListNode.new(list1.val, list1.next)
  end

  if list1.val < list2.val
    next1 = list1.next
    next2 = list2
    v = list1.val
  else
    next1 = list1
    next2 = list2.next
    v = list2.val
  end
  ListNode.new(v, merge_two_lists(next1, next2))
end