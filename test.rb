# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
  return s if num_rows == 1
  k = s.size/(2*num_rows -2) + 1

  rows = {}
  k.times do |i|
    temp = s[i*(2*num_rows-2),2*num_rows-2]
    num_rows.times do |row_index|
      rows[row_index] ||= []
      rows[row_index] << temp[row_index]
      next if row_index == 0 || row_index == num_rows-1
      rows[row_index] << temp[2*num_rows-2-row_index]
    end
  end
  rows.values.join
end

# @param {Integer} num
# @return {String}
def int_to_roman(num)
  g = num % 10
  s = num % 100 / 10
  b = num % 1000 / 100
  q = num / 1000

  qs = "".rjust(q, "M")
  bs = spec(b,"C","D","M")
  ss = spec(s,"X","L","C")
  gs = spec(g,"I","V","X")
  qs + bs + ss + gs
end

def spec(n,s1,s5,s9)
  case n
  when 1,2,3
    "".rjust(n,s1)
  when 4
    s1+s5
  when 5
    s5
  when 6,7,8
    s5+"".rjust(n%5,s1)
  when 9
    s1+s9
  else
    ""
  end
end

# @param {String} digits
# @return {String[]}
def letter_combinations(digits)
  return [] if digits.size == 0
  _hash = {
    "2"=> %w[a b c],
    "3"=> %w[d e f],
    "4"=> %w[g h i],
    "5"=> %w[j k l],
    "6"=> %w[m n o],
    "7"=> %w[p q r s],
    "8"=> %w[t u v],
    "9"=> %w[w x y z]
  }
  arrs = []
  digits.size.times do |i|
    arrs << _hash[digits[i]]
  end

  arr_str = []
  arrs.each do |arr|
    if arr_str.empty?
      arr_str = arr
      next
    end
    temp = []
    arr_str.each do |t|
      arr.each do |a|
        temp << (t + a)
      end
    end
    arr_str = temp
  end
  arr_str
end
