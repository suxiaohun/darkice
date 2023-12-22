# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  _hash = {}
  nums.each_with_index do |n, i|
    temp_b = target - n
    return i, _hash[temp_b] if _hash[temp_b]
    _hash[n] = i
  end
end

# 两数之和