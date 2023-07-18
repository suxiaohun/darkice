# some times you need get image from hub, and change it's tag, then re push to the repo

repo = "xxx.xxx.com"
namespace = "xxx"
version = "v6.5.0"
prefix = "pingcap"

arr = []
arr << ["pd", "tidb-pd"]
arr << ["tikv", "tidb-tikv"]
arr << ["tidb", "tidb-tidb"]

arr.each do |obj|
  old_image = "#{prefix}/#{obj[0]}:#{version}"
  new_image = "#{repo}/#{namespace}/#{obj[1]}:#{version}-amd64"
  `docker pull #{image}`
  `docker tag #{old_image} #{new_image}`
  `docker push #{new_image}`
end


