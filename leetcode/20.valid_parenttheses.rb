# @param {String} s
# @return {Boolean}
def is_valid(s)
  temp = nil
  until temp == s
    temp = s
    s = s.gsub('()', '')
    s = s.gsub('{}', '')
    s = s.gsub('[]', '')
  end
  s == ''
end
