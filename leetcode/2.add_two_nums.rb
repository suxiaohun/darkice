# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2, extra = 0)
  if l1.nil? && l2.nil?
    if extra != 0
      return ListNode.new(extra)
    end
    return
  end

  v1 = l1.nil? ? 0 : l1.val
  v2 = l2.nil? ? 0 : l2.val
  next1 = l1.nil? ? nil : l1.next
  next2 = l2.nil? ? nil : l2.next

  val = v1 + v2 + extra
  if val > 9
    extra = 1
    val = val - 10
  else
    extra = 0
  end

  ListNode.new(val, add_two_numbers(next1, next2, extra))
end

# 单链表相加，注意进位即可
