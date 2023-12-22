# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
  max_sum = nums[0]
  sum = 0
  nums.each do |n|
    sum += n
    max_sum = sum if sum > max_sum
    sum = 0 if sum < 0
  end
  max_sum
end