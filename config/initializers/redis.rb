$redis = Redis::Namespace.new("my_app", :redis => Redis.new(url:"redis://#{ENV["REDIS_HOST"]}/2/cache"))

