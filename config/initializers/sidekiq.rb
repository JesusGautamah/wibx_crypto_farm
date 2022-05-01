# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: (ENV['REDIS_SERVER'] || 'redis://localhost:6379/0') }
end
