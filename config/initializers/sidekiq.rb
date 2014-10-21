Sidekiq.configure_server do |config|
    config.redis = { url: RedisSettings.server.url, namespace: RedisSettings.server.namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { url: RedisSettings.client.url, namespace: RedisSettings.client.namespace }
end
