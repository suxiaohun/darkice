require 'uri'
require 'net/http'
require 'pry'
require 'json'
require 'time'
require 'fileutils'

TIME_THRESHOLD = 24 * 60 * 60
TIME_THRESHOLD2 = 5 * 60
# BM_HOST = "bm.batch:9989" # todo
BM_HOST = "172.20.25.51:30080/components/batch-manager-default"

# MOUNT_PATH = "/mnt/locals/datafusion-elasticsearch/volume0/spark-data/spark-data" # todo
MOUNT_PATH = "/tmp/locals/datafusion-elasticsearch/volume0/spark-data" # todo


def get_jobs
  start_date = (Time.now - 2 * TIME_THRESHOLD).strftime("%Y-%m-%dT%H:%M:%SZ")
  jobs_url="http://#{BM_HOST}/v1/jobs?catalog=inc-clustering&period.start=#{start_date}"

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

def clean_old_dirs(path)
  # 有些时候，很多不为空的目录也不用了，也需要删除，所以要从cached_jobs里，去除正在running的那些dir，其他的都可以删除
  # （考虑到极端情况，遍历的时候，有新的job目录在创建，只删除5分钟之前创建的目录）
  begin
  Dir.chdir(path) do
    Dir.glob("*") do |dd|
      if File.directory? dd
        next if dd == "worker"
        stat = File.stat dd

        # 删除两天前的无用目录
        diff = Time.now - stat.atime
        if diff > TIME_THRESHOLD
          puts "delete old date dir: #{dd}, last_visited_at: #{stat.atime}, diff_time: #{diff}"
          # FileUtils.rm_rf dd
          next
        end

        # 删除空目录
        if Dir.empty? dd
          puts "delete old empty dir: #{dd}"
          # FileUtils.rm_rf dd
          next
        end

        # 删除5分钟之前的目录
        diff2 = Time.now - stat.atime
        if diff2 > TIME_THRESHOLD2
          puts "delete old date dir: #{dd}, last_visited_at: #{stat.atime}, diff_time: #{diff}"
          # FileUtils.rm_rf dd
          next
        end
      end
    end
  end
  rescue SystemCallError => e
    puts "#{path} not exist"
  end
end

cached_jobs = {}
while true
  latest_jobs = get_jobs
  puts "---#{Time.now}---get #{latest_jobs.count} jobs---cached #{cached_jobs.count} jobs---"
  latest_jobs.each do |job|
    # 只有running的job需要缓存在hash中（目录相关信息，只记录一下），如果下次loop，缓存中已经存在，则跳过
    if job["result"]["status"] == "RUNNING"
      next if job["job_type"] != "SPARK"
      next if cached_jobs.has_key? job["id"]
      temp_job = {
        "job_id" => job["id"],
        "job_name" => job["name"],
        "expired_time" => Time.now
      }
      job["role_status"].each do |role|
        if role["role_name"] == "worker"
          role["pod_status"].each do |ss|
            temp_job["clean_dirs"] ||= {}
            # pod_ip = ss["ip"] # todo use pod id
            pod_ip = "172.20.25.51"
            begin
            app_id_str = `curl -s  http://#{pod_ip}:8081/ | grep ID | grep app`
            app_id = app_id_str.split[-1].split('<')[0]

            worker_path = job["application_master"]["environments"]["SPARK_WORKER_DIR"]
            worker_path += "/#{app_id}" if worker_path

            spark_path_str = `curl -s  'http://#{pod_ip}:8081/logPage/?appId=#{app_id}&executorId=0&logType=stderr&offset=0' |grep spark-data`
            spark_path = spark_path_str.split[8].split("executor")[0]
            temp_job["clean_dirs"][ss["ip"]] = { "app_id" => app_id, "spark_path" => spark_path, "worker_path" => worker_path }
            rescue Exception => e
              puts "===============#{job["id"]} exception========================"
              puts e.message
              puts "role_status: #{job["role_status"]}"
              puts "===============#{job["id"]} exception========================"
              next
            end
          end
        end
      end
      cached_jobs[job["id"]] = temp_job
      next
    end

    if cached_jobs.has_key? job["id"]
      cached_jobs[job["id"]]["clean_dirs"].each do |_, info|
        spark_path = info["spark_path"]
        worker_path = info["worker_path"]
        if spark_path
          # FileUtils.rm_rf "#{spark_path}"
          puts "delete failed job---#{job["id"]}=>#{job["name"]}---dirs: spark_path=>#{spark_path}"
        end

        if worker_path && job["result"]["status"] == "FINISHED"
          # FileUtils.rm_rf "#{worker_path}"
          puts "delete failed job---#{job["id"]}=>#{job["name"]}---dirs: worker_path=>#{worker_path}"
        end
      end
      cached_jobs.delete job["id"]
    end
  end
  clean_old_dirs(MOUNT_PATH) # 清理spark-data
  clean_old_dirs(MOUNT_PATH+"/worker") # 清理spark-data/worker
  sleep 5
end

# "PENDING" "INITIALIZING" "WAITING_MASTER" "ALLOCATING" "RUNNING" "FINISHED" "FAILED" "CANCELED" "PARTIAL_FAILED"


