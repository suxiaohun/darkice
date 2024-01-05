require 'uri'
require 'net/http'
require 'pry'
require 'json'
require 'time'
require 'fileutils'

TIME_THRESHOLD = 20 * 60 * 60
TIME_THRESHOLD2 = 5 * 60

# HOST="http://172.20.25.95:30080"
HOST="http://172.20.26.216:30080"
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

def convert_time(s_time, e_time)
  return "" if e_time.nil? || s_time.nil?
  seconds = (e_time - s_time).to_i
  hours = seconds / 3600
  minutes = (seconds % 3600) / 60
  remaining_seconds = seconds % 60

  "#{hours}h #{minutes}min #{remaining_seconds}s"
end

max_count = (ARGV[0] || 10).to_i
job_id = ARGV[1]

jobs = get_jobs
jobs = get_jobs((Time.now - 4 * TIME_THRESHOLD).strftime("%Y-%m-%dT%H:%M:%SZ")) if jobs.count < 5

# jobs = jobs.each {|x| x["name"]=="classification_job"}
# id,.name,.result.status,.created_at,.finished_at
count = 0
jobs.each do |job|
  count += 1
  break if count > max_count

  s_time = nil
  e_time = nil
  s_time = Time.parse(job["created_at"]) + 8 * 60 * 60 if job["created_at"]
  e_time = Time.parse(job["finished_at"]) + 8 * 60 * 60 if job["finished_at"]
  cost = convert_time(s_time, e_time)

  puts "#{job["id"].ljust(5)} #{job["name"].ljust(28)} #{job["result"]["status"].ljust(8)} #{s_time.strftime("%Y-%m-%d %H:%M:%S") rescue ""} #{e_time.strftime("%Y-%m-%d %H:%M:%S") rescue ""} #{cost}"
  unless job_id.nil?
    if job_id == job["id"]
      job_detail = get_job(job["id"])
      puts "----------------------------------------"
      job_detail["events"].each do |event|
        puts "#{event["timestamp"]} => #{event["reason"]}"
      end
      puts "----------------------------------------"
    end
  end
end


