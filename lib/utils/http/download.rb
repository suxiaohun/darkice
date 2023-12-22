require 'net/http'
require 'json'

def download(bucket_name, dir_name)
  host = "http://172.20.25.15"
  port = "31998"
  path = "buckets/#{bucket_name}/#{dir_name}?pretty=y"
  uri = URI("#{host}:#{port}/#{path}")
  Net::HTTP.start(uri.host, uri.port) do |http|
    req = Net::HTTP::Get.new(uri, { "Accept" => "application/json" })
    res = http.request req
    res = JSON.parse(res.body)
    res["Entries"].each do |obj|
      puts obj["FullPath"]

    end
  end
end

download("cylon-internal-ingress", "20221111")