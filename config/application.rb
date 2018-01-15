require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.i18n.default_locale = :"en"

    config.time_zone = "Beijing"

    config.active_record.default_timezone = :local

    config.active_job.queue_adapter = :sidekiq


    redis_config_hash = {url: "redis://#{ENV["REDIS_HOST"]}/0/cache", expires_in: 1.days}

    if Sidekiq.server? # threaded context
      redis_config_hash[:pool_size] = Sidekiq.options[:concurrency] + 5
      redis_config_hash[:pool_timeout] = 1
    end

    config.cache_store = :redis_store, redis_config_hash

    console do
      require "pry"
      config.console = Pry
    end

  end
end
