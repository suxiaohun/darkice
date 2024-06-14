# Sidekiq.configure_server do |config|
#   # config.redis = {namespace: 'xiaopang', size: 25, url: "redis://#{XiaopangEnv.redis.host}:#{XiaopangEnv.redis.port}/#{XiaopangEnv.redis.db}"}
#   config.redis = {namespace: 'darkice', size: 25, url: "redis://10.4.243.51:30379/0"}
# end
#
# Sidekiq.configure_client do |config|
#   # config.redis = {namespace: 'xiaopang', size: 1, url: "redis://#{XiaopangEnv.redis.host}:#{XiaopangEnv.redis.port}/#{XiaopangEnv.redis.db}"}
#   config.redis = {namespace: 'xiaopang', size: 1, url: "redis://10.4.243.51:30379/0"}
# end

#Sidekiq.configure_server do |_config|
#  Yabeda::Prometheus::Exporter.start_metrics_server!
#end