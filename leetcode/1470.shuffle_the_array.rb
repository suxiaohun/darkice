# @param {Integer[]} nums
# @param {Integer} n
# @return {Integer[]}
def shuffle(nums, n)
  new_arr = []
  n.times do |i|
    new_arr << nums[i]
    new_arr << nums[i + n]
  end
  new_arr
end