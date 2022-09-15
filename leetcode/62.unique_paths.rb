# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths(m, n)
  return 1 if m + n == 2
  arr = []
  @right = m - 1
  @bottom = n - 1
  (m + n - 2).times do |i|
    if i == 0
      arr << { right: 1, bottom: 0 } if @right > 0
      arr << { right: 0, bottom: 1 } if @bottom > 0
      next
    end
    arr = gen(arr)
  end
  arr.size
end

def gen(arr)
  arr1 = []
  arr.each do |obj|
    if obj[:right] > (@right - 1) || obj[:bottom] > (@bottom - 1)
      arr1 << obj
      next
    end

    arr1 << { right: obj[:right] + 1, bottom: obj[:bottom] }
    arr1 << { right: obj[:right], bottom: obj[:bottom] + 1 }
  end
  arr1
end

def test(m, n)
  count = 1
  min = [m, n].min - 1
  max = [m, n].max - 1
  (min + max).times do |i|
    count = count * 2
  end

  (min + max).times do |i|
    temp1 = i - min + 1
    if temp1 >= 0 &&  temp1 <= min
      count = count - 2 ** (temp1 + 1) + 1
    end
    temp2 = i - max + 1
    if temp2 >= 0
      count = count - 2 ** (temp2 + 1) + 1
    end
  end
  count
end