# @param {Integer} n
# @return {Integer}
def climb_stairs(n)
  return 1 if n == 1
  return 2 if n == 2
  n1 = 0
  n2 = 0

  (n - 1).times do |i|
    if i == 0
      n1 = 1
      next
    end
    if i == 1
      n2 = 2
      next
    end
    temp = n1 + n2
    n1, n2 = n2, temp
  end

  n1 + n2
end