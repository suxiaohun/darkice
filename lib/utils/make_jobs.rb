require 'uri'
require 'net/http'
require 'pry'
require 'json'
require 'time'
require 'fileutils'

$stdout.sync = true

TIME_THRESHOLD = 20 * 60 * 60
TIME_THRESHOLD2 = 5 * 60




BM_HOST = "http://172.20.25.95:30080/components/batch-manager-default"
JOB_URL = "#{BM_HOST}/v1/jobs"


cluster_count=5000_0000
feature_multi= 5

batch_cluster_count=100_0000 # 每次跑100w的cluster

def get_job(job_id)
  uri = URI("#{JOB_URL}/#{job_id}")
  res = Net::HTTP.get_response(uri)
  if res.is_a?(Net::HTTPSuccess)
    JSON.parse(res.body)
  else
    {}
  end
end

def make_job(cluster_count,feature_count)
  url = URI.parse(JOB_URL)
  request = Net::HTTP::Post.new(url.path, {'Content-Type' => 'application/json'})
  request.body = '{
    "job":{
        "name":"data-fusion",
        "resource_pool1":"data-timespace-incremental-clustering",
        "resource_pool":"data-analysis",
        "application_master":{
            "name":"master",
            "role_type":1,
            "pod_config":{
                "cpu":{
                    "request":2000,
                    "limit":4000
                },
                "memory":{
                    "request":1024,
                    "limit":8192
                },
                "image_pull_policy":"Always"
            },
            "command":[
                "/bin/sh",
                "-c",
                "python -m bm_jobs.tsfd_clustering.generate_clusters.generate_clusters_job3"
            ],
            "environments":{
                "DATE":"20230918",
                "TEST_HOST":"172.20.25.95",
                "REGION_ID_MAX": "1000",
                "FACE_FEATURE_COUNT":"'+feature_count+'",
                "FACE_CLUSTER_COUNT":"'+cluster_count+'",
                "ONE_ENTITY_ONE_CLUSTER":"true",
                "ANONYMOUS_FLAG":"true",
                "IDENTIFIED_FLAG":"false",
            	"HDFS_NAMENODE_SERVICE":"hdfs-namenode-default.component.svc.cluster.local",
                "SPARK_LOCAL_DIRS": "/mnt/locals/datafusion-elasticsearch/volume0/spark-data",
                "LOCAL_CACHE_PATH": "/mnt/locals/datafusion-elasticsearch/volume0/spark-data",
                "CUDA_CACHE_PATH": "/mnt/locals/datafusion-elasticsearch/volume0/spark-data/.nv/ComputeCache",
                "WORKER_NUM":"1",
                "WORKER_CPUS":"34",
                "WORKER_MEMORY":"308640"
            },
            "image":"registry.sensetime.com/viper-test/big_data_test:v5.4.0-5f23f36-amd64"
        },
        "parameters":"",
        "catalog":"data-fusion",
        "retries":3,
        "timeout":86400
    }
}'

  # 发送请求
  response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
    http.request(request)
  end

  puts response
  response
end

job_id=nil

while cluster_count > 0
  unless job_id
    job_id=make_job(batch_cluster_count,batch_cluster_count * feature_multi)
  end
  if job_id
    job =get_job(job_id)
    if job["result"]["status"] == "RUNNING"
      sleep 5
    end

    if job["result"]["status"] == "FINISHED"
      puts ""
    end

  end
  batch_feature_count = batch_cluster_count * feature_multi


  # 保证没有造数据的job在运行，如果job存在，就循环查询job状态，如果job状态不再是running，就下发一个job

  # job["result"]["status"] == "RUNNING"


end




