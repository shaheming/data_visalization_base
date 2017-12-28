$redis = Redis::Namespace.new("mywebsite", :redis => Redis.new)
# url:'redis://redis:6379/1/cache'