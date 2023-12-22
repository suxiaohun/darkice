# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  _hash = {}
  start = 0
  lens = []
  s.size.times do |i|
    if _hash[s[i]] && _hash[s[i]] >= start
      lens << (i - start)
      start = _hash[s[i]] + 1
    end
    _hash[s[i]] = i
  end
  lens << (s.size - start)
  lens.max
end


def length_of_longest_substring2(s)
  last = {}
  start = 0
  uniq = 0
  s.size.times do |i|
    start = [start,(last[s[i]]||-1)+1].max
    uniq = [uniq,i-start+1].max
    last[s[i]]=i
  end
  uniq
end