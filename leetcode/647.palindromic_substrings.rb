# @param {String} s
# @return {Integer}
def count_substrings(s)
  size = s.size
  last = nil
  total_count = 0
  size.times do |i|

    _hash = {
      left: i,
      right: i,
      len: 1
    }
    if s[i] == last
      check_center2(s, s[i], _hash, size)
      total_count += _hash[:len]
      next
    end
    check_center(s, s[i], _hash, size)
    check_border(s, _hash, size)

    total_count += _hash[:len]
    last = s[i]
  end
  total_count

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

def check_center2(s, str, _hash, size)
  while (_hash[:right] + 1 < size) && (s[_hash[:right] + 1] == str)
    _hash[:len] += 1
    _hash[:right] += 1
  end
end

def check_border(s, _hash, size)
  while (_hash[:left] - 1 > -1) && (_hash[:right] + 1 < size) && (s[_hash[:left] - 1] == s[_hash[:right] + 1])
    _hash[:len] += 1
    _hash[:left] -= 1
    _hash[:right] += 1
  end
end
