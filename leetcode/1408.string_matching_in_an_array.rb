# @param {String[]} words
# @return {String[]}
def string_matching(words)
  words.sort_by! { |x| x.size }

  arr = []
  words.each_with_index do |w1, i1|
    words.each_with_index do |w2, i2|
      next if i2 < i1 + 1
      arr << w1 if w2.include? w1
    end
  end
  arr.uniq
end