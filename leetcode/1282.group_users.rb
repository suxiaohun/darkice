# @param {Integer[]} group_sizes
# @return {Integer[][]}
def group_the_people(group_sizes)

  arr = []
  _hash = {}
  group_sizes.each_with_index do |g, i|
    _hash[g] ||= []
    if _hash[g].size == g
      arr << _hash[g]
      _hash[g] = []
    end
    _hash[g] << i
  end
  arr + _hash.values
end