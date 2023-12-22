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
# @return {Integer}
def deepest_leaves_sum(root)
  @_hash = {}
  dfs(root, 0)
  max_key = @_hash.keys.max
  puts @_hash
  @_hash[max_key].sum
end

def dfs(root, level)
  return if root.nil?
  level += 1
  dfs(root.left, level)
  @_hash[level] ||= []
  @_hash[level] << root.val
  dfs(root.right, level)
end