redis_config = Rails.application.config.redis_config
schedule_file = Rails.root.join('config/schedule.yml')

RedisClient.default_driver = redis_config.fetch(:driver, :redis)

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
