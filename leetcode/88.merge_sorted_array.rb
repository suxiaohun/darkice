# @param {Integer[]} nums1
# @param {Integer} m
# @param {Integer[]} nums2
# @param {Integer} n
# @return {Void} Do not return anything, modify nums1 in-place instead.
def merge(nums1, m, nums2, n)
  pick(nums1, m, nums2, n)
end

def pick(nums1, m, nums2, n)
  if (n - 1 < 0) && (m - 1 < 0)
    return
  end

  p1 = nums1[m - 1]
  p1 = -10000000000 if (m - 1) < 0
  p2 = nums2[n - 1]
  p2 = -10000000000 if (n - 1) < 0

  if p1 > p2
    nums1[m + n - 1] = nums1[m - 1]
    m -= 1
  else
    nums1[m + n - 1] = nums2[n - 1]
    n -= 1
  end
  pick(nums1, m, nums2, n)
end

