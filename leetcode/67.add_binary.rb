# @param {String} a
# @param {String} b
# @return {String}
def add_binary(a, b)
  a.reverse!
  b.reverse!
  a, b = b, a if a.size > b.size

  c = ""
  extra = 0
  b.size.times do |i|
    temp = a[i].to_i + b[i].to_i + extra
    if temp > 1
      c << (temp - 2).to_s
      extra = 1
    else
      c << temp.to_s
      extra = 0
    end
  end

  c << "1" if extra ==
    c.reverse
end