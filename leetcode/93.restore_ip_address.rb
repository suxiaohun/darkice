# @param {String} s
# @return {String[]}
def restore_ip_addresses(s)
  return [] if s.size > 12 || s.size < 4
  case s.size
  when 4
    return s.scan(/./)
  when 5
    
  end


end
