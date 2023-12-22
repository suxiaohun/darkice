REDIS_CONFIG = {}
# todo disable env
# REDIS_CONFIG[:host] = XiaopangEnv.redis.host
REDIS_CONFIG[:host] = "10.4.243.51"
# REDIS_CONFIG[:port] = XiaopangEnv.redis.port
REDIS_CONFIG[:port] = "6379"
REDIS_CONFIG[:db] = Rails.env.test? ? 3 : 0

redis = Redis.new(REDIS_CONFIG)

RATE_REDIS = Redis::Namespace.new(:rate, redis: redis)
YYS_REDIS = Redis::Namespace.new(:yys, redis: redis)

BOOK_REDIS = Redis::Namespace.new(:book, redis: redis)