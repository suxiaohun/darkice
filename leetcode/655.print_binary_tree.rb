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
# @return {String[][]}
def print_tree(root)
  @res = []
  @hash = {}

  dfs1(root,0)
  @height = @hash.keys.size-1
  puts @height

  @hash= {}
  @n = 2 ** (@height + 1) - 1

  col = (@n - 1) / 2
  puts col
  dfs(root, 0, col)

  @hash.sort.map(&:last)
end

def dfs1(root,height)
  return if root.nil?
  dfs1(root.left,height+1)
  @hash[height]=root.val
  dfs1(root.right,height+1)
end

def dfs(root, r, c)
  return if root.nil?
  dfs(root.left, r + 1, c - 2 ** (@height - r - 1))
  @hash[r] ||= [""] * @n
  @hash[r][c] = root.val.to_s
  dfs(root.right, r + 1, c + 2 ** (@height - r - 1))
end