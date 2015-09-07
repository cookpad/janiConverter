Sidekiq.configure_server do |config|
    config.redis = { url: RedisSettings.server.url, namespace: RedisSettings.server.namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { url: RedisSettings.client.url, namespace: RedisSettings.client.namespace }
end

Sidekiq::Logging.logger = if Rails.env.test?
    nil
  elsif ENV["LOG_DIR_PATH"].present?
    Logger.new("#{ENV["LOG_DIR_PATH"]}/#{Rails.env}.log")
  else
    Logger.new(STDOUT)
  end
