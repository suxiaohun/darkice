# @param {Integer[]} temperatures
# @return {Integer[]}
def daily_temperatures(temperatures)
  size = temperatures.size
  res = [0] * size
  (size - 2).downto(0) do |i|
    j = i + 1
    while true
      if temperatures[i] < temperatures[j]
        res[i] = j -i
        break
      elsif res[j] == 0
        res[i] == 0
        break
      end
      j = j + res[j]
    end
  end
  res
end
