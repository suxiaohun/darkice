# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
  arr = []
  @n = n
  arr << { left: 1, right: 0, str: '(' }
  (n * 2 - 1).times do |i|
    next if i == 0
    arr = gen(arr)
  end

  arr2 = []
  arr.each do |s|
    arr2 << (s[:str] + ')')
  end
  arr2
end

def gen(arr)
  arr1 = []
  arr.each do |s|
    if s[:left] < @n
      arr1 << { left: s[:left] + 1, right: s[:right], str: s[:str] + '(' }
    end
    if s[:right] < s[:left]
      arr1 << { left: s[:left], right: s[:right] + 1, str: s[:str] + ')' }
    end
  end
  arr1
end