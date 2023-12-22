# require 'aws-sdk-s3'
#
# s3 = Aws::S3::Client.new(
#   region: "cn-north-1",
#   credentials: Aws::Credentials.new("32ea52a7f24748e0a9c685827d4ec3c1", "4beaad5bbfc14e99b8d9ee953e1e29d9")
# )
# resp = s3.list_buckets
# resp.buckets.map(&:name)
# puts 111
#

require 'minio'

conf = MinioRuby::Config.new(
  endpoint: "http://172.20.25.15:31999",
  access_key: "32ea52a7f24748e0a9c685827d4ec3c1",
  secret_key: "4beaad5bbfc14e99b8d9ee953e1e29d9",
)

MinioRuby::Client.configuration = conf

c= MinioRuby::Client.new
# buckets =  c.list_buckets
# buckets.each do |b|
#   puts b.name
# end
objs = c.get_object("cylon-internal-ingress","")
objs.each do |obj|
  puts obj.name
end






