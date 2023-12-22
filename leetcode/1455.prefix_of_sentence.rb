# @param {String} sentence
# @param {String} search_word
# @return {Integer}
def is_prefix_of_word(sentence, search_word)
  words = sentence.split
  words.each_with_index do |w, i|
    next if w.size < search_word.size
    return (i + 1) if w[0..search_word.size-1] == search_word
  end
  -1
end