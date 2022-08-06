# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Void} Do not return anything, modify root in-place instead.
def recover_tree(root)
  arr = []
  dfs(root, arr)

  pre = arr[0]
  x, y = nil
  arr.each_with_index do |a, i|
    next if i == 0
    if pre.val > a.val
      y = a
      x = pre if x == nil
    end
    pre = a
  end
  x.val, y.val = y.val, x.val
end

def dfs(root, arr)
  return unless root
  dfs(root.left, arr)
  arr << root
  dfs(root.right, arr)
end
