require_relative 'boot'
require 'rails/all'
require 'oembed'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load
module Recho
  class Application < Rails::Application
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
    end
    config.time_zone = 'Tokyo'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.i18n.default_locale = :ja

    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths += %W[#{config.root}/lib #{config.root}/app/validators]
    config.action_view.field_error_proc = proc { |html_tag, _instance| html_tag }
  end
end
