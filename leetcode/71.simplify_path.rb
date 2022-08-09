# @param {String} path
# @return {String}
def simplify_path2(path)
  return "/" if path == "/../"
  path += "/"
  while path.gsub!("//", "/")
  end
  puts path
  while path.gsub!("/./", "/")
  end
  puts path

  paths = path.split("/")
  paths2 = paths.dup
  _del_index = []

  paths2.each_with_index do |p, i|
    if p == ".."
      _del_index << i
    end
  end

  count = 0
  _del_index.each do |i|
    if paths[i - count - 1] != ""
      paths.delete_at(i - count - 1)
      paths.delete_at(i - count - 1)
      count += 2
    else
      paths.delete_at(i - count)
      count += 1
    end
  end

  puts paths
  path = paths.join("/")

  path = "/" + path if path[0] != "/"
  path
end

# @param {String} path
# @return {String}
def simplify_path(path)
  real_paths = []
  paths = path.split("/")
  paths.each do |p|
    if p == ".."
      real_paths.pop
    elsif p == "." || p == ""

    else
      real_paths << p
    end
  end
  puts real_paths.to_s
  aa = real_paths.join("/")
  aa.chop! if aa[-1] == "/"
  aa= "/"+aa if aa[0] != "/"
  aa
end

