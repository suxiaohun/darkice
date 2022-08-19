# @param {Integer[]} start_time
# @param {Integer[]} end_time
# @param {Integer} query_time
# @return {Integer}
def busy_student(start_time, end_time, query_time)
  p1 = start_time[0]
  p2 = end_time[0]
  count = 0
  index = 0
  while p1 && p2
    index += 1
    count += 1 if query_time >= p1 && query_time <= p2
    p1 = start_time[index]
    p2 = end_time[index]
  end
  count
end