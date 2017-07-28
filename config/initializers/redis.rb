# encoding: utf-8
# frozen_string_literal: true

require 'redis'

REDIS = if Rails.env.production? && ENV.fetch('REDISCLOUD_URL')
          Redis.new(url: ENV.fetch('REDISCLOUD_URL'))
        else
          Redis.new(url: 'redis://localhost:6379')
        end
