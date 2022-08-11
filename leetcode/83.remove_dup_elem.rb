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
def delete_duplicates(head)
  return if head.nil?
  delete_duplicates2(head, nil)
  head
end

def delete_duplicates2(head, pre)
  return if head.nil?
  if pre && pre.val == head.val
    pre.next = head.next
  else
    pre = head
  end
  delete_duplicates2(head.next, pre)
end