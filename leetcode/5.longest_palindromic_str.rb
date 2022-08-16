# @param {String} s
# @return {String}
def longest_palindrome(s)
  max_hash = {
    left: 0,
    right: 0,
    len: 1
  }

  size = s.size
  last = nil
  size.times do |i|
    break if ((size - i) * 2) < max_hash[:len]
    next if s[i] == last
    _hash = {
      left: i,
      right: i,
      len: 1
    }
    check_center(s, s[i], _hash, size)
    check_border(s, _hash, size)

    if _hash[:len] > max_hash[:len]
      max_hash = _hash
    end
    last = s[i]
  end
  s[max_hash[:left]..max_hash[:right]]
end

def check_center(s, str, _hash, size)
  while (_hash[:left] - 1 > -1) && (s[_hash[:left] - 1] == str)
    _hash[:len] += 1
    _hash[:left] -= 1
  end
  while (_hash[:right] + 1 < size) && (s[_hash[:right] + 1] == str)
    _hash[:len] += 1
    _hash[:right] += 1
  end
end

def check_border(s, _hash, size)
  while (_hash[:left] - 1 > -1) && (_hash[:right] + 1 < size) && (s[_hash[:left] - 1] == s[_hash[:right] + 1])
    _hash[:len] += 2
    _hash[:left] -= 1
    _hash[:right] += 1
  end
end
