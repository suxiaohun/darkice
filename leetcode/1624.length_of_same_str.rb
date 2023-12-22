# @param {String} s
# @return {Integer}
def max_length_between_equal_characters(s)
  _hash = {}
  lens = [-1]

  s.size.times do |i|
    if _hash[s[i]]
      lens << (i - _hash[s[i]] - 1)
      next
    end
    _hash[s[i]] = i
  end

  lens.max
end

# 计算两个相同字符之间的字符最大长度，长度不包含两个字符本身
# 注意点：中间的字符也可以相同，起始点永远是字符第一次出现的位置