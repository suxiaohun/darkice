require 'uri'
require 'net/http'
require 'pry'
require 'json'
require 'time'
require 'fileutils'
require './job_base'
include JobBase

TIME_THRESHOLD = 20 * 60 * 60
TIME_THRESHOLD2 = 5 * 60

#HOST="http://172.20.25.95:30080"
HOST="http://172.20.25.55:30080"
BM_HOST = "#{HOST}/components/batch-manager-default"

JOB_URL = "#{BM_HOST}/v1/jobs"

def get_jobs(start_date = ((Time.now - 2 * TIME_THRESHOLD).strftime("%Y-%m-%dT%H:%M:%SZ")))
  # jobs_url = "#{JOB_URL}?catalog=inc-clustering&period.start=#{start_date}"
  jobs_url = "#{JOB_URL}?period.start=#{start_date}"

  # uri = URI(jobs_url)
  # res = Net::HTTP.get_response(uri)
  # page = []
  # if res.is_a?(Net::HTTPSuccess)
  #   temp = JSON.parse res.body
  #   page = temp["page"]
  # end
  #
  # puts "----#{page}----"
  #
  # offset = page["total"].to_i - 100
  # offset = 0 if offset < 0
  # condition = "&page.offset=#{offset}"
  # uri = URI(jobs_url + condition)

  uri = URI(jobs_url)
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

max_count = (ARGV[0] || 10).to_i
job_id = ARGV[1]
show_detail = ARGV[2]
jobs = get_jobs
loop=1

while loop < 8
  if jobs.count < max_count
    loop+=1
    jobs = get_jobs((Time.now - loop * TIME_THRESHOLD).strftime("%Y-%m-%dT%H:%M:%SZ"))
    next
  end
  break
end


if show_detail
  analyze2(jobs, max_count, job_id,MODE_ONLINE)
else
  analyze1(jobs, max_count, job_id,MODE_ONLINE)
end



