require 'uri'
require 'net/http'
require 'pry'
require 'json'
require 'time'
require 'fileutils'

TIME_THRESHOLD = 20 * 60 * 60
TIME_THRESHOLD2 = 5 * 60

BM_HOST = "http://172.20.25.95:30080/components/batch-manager-default"

JOB_URL = "#{BM_HOST}/v1/jobs"


def get_jobs
  start_date = (Time.now - 2 * TIME_THRESHOLD).strftime("%Y-%m-%dT%H:%M:%SZ")
  jobs_url="#{JOB_URL}?catalog=inc-clustering&period.start=#{start_date}"

  uri = URI(jobs_url)
  res = Net::HTTP.get_response(uri)
  page = []
  if res.is_a?(Net::HTTPSuccess)
    temp = JSON.parse res.body
    page = temp["page"]
  end

  offset = page["total"] - 100
  offset = 0 if offset < 0
  condition = "&page.offset=#{offset}"

  uri = URI(jobs_url + condition)
  res = Net::HTTP.get_response(uri)
  if res.is_a?(Net::HTTPSuccess)
    JSON.parse(res.body)["jobs"]
  else
    {}
  end
end

def get_job(job_id)
  uri = URI("#{JOB_URL}/#{job_id}")
  res = Net::HTTP.get_response(uri)
  if res.is_a?(Net::HTTPSuccess)
    JSON.parse(res.body)
  else
    {}
  end
end

job_id = ARGV[0]

jobs = get_jobs
jobs = jobs.each {|x| x["name"]=="classification_job"}
# id,.name,.result.status,.created_at,.finished_at


jobs.each do |job|
  puts "#{job["id"]} #{job["name"]} #{job["result"]["status"]} #{job["created_at"]} #{job["finished_at"]}"
  unless job_id.empty?
    next if job["id"] != job_id
  end
  job_detail = get_job(job["id"])
  puts "----------------------------------------"
  job_detail["events"].each do |event|
    puts "#{event["timestamp"]} => #{event["reason"]}"
  end
  puts "----------------------------------------"
end


