# encoding: utf-8
# frozen_string_literal: true

require 'redis'

Sidekiq.configure_server do |config|
  config.redis = if Rails.env.production?
                   { url: ENV.fetch('REDISCLOUD_URL'), namespace: "sidekiq_#{Rails.env}" }
                 else
                   { url: 'redis://localhost:6379', namespace: "sidekiq_#{Rails.env}" }
                 end
end

Sidekiq.configure_client do |config|
  config.redis = if Rails.env.production?
                   { url: ENV.fetch('REDISCLOUD_URL'), namespace: "sidekiq_#{Rails.env}" }
                 else
                   { url: 'redis://localhost:6379', namespace: "sidekiq_#{Rails.env}" }
                 end
end
