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
# @return {Boolean}
# 需要验证所有节点，所以要从最后一个节点开始算

def is_valid_bst(root)
  @last = -2 ** 31 - 1
  dfs(root) rescue false
end

def dfs(root)
  return true if root.nil?
  dfs(root.left)
  raise "err" if root.val <= @last

  @last = root.val
  dfs(root.right)
end


