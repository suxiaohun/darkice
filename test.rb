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