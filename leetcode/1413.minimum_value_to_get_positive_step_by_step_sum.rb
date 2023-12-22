# @param {Integer[]} nums
# @return {Integer}
def min_start_value(nums)
  start_value = 1
  start_value = 0 - nums[0] + 1 if nums[0] < 0

  sum1 = start_value
  sum2 = 0
  nums.each do |n|
    temp = sum1 + n
    sum2 += n
    if temp < 1
      start_value = start_value + 1 - temp
      sum1 = start_value + sum2
      next
    end
    sum1 += n
  end
  start_value
end