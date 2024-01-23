require 'uri'
require 'net/http'
require 'pry'
require 'json'
require 'time'
require 'fileutils'
require './job_base'
include JobBase


path = "/Users/crystal/Downloads/clustering_log_nj_2024_0117"

max_count = (ARGV[0] || 10).to_i
job_id = ARGV[1]
show_detail = ARGV[2]

jobs = []
Dir.glob("#{path}/*") do |file_name|
  jobs << JSON.parse(File.read(file_name))
end

if show_detail
  analyze2(jobs, max_count, job_id,MODE_OFFLINE)
else
  analyze1(jobs, max_count, job_id,MODE_OFFLINE)
end







