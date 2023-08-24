require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load if %w[development test].include?(Rails.env)

module Divercoin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.generators do |generate|
      generate.system_tests = nil
      generate.test_framework :rspec
      generate.stylesheets false
      generate.javascripts false
      generate.views false
      generate.stylesheet_engine nil
    end

    config.redis_config = {
      url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0'),
      driver: :hiredis
    }

    config.active_job.queue_adapter = :sidekiq

    config.action_mailer.deliver_later_queue_name = :mailers

    config.i18n.available_locales = %i[en es]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = %i[en]
    config.i18n.load_path = Dir[Rails.root.join('config/locales/**/*.{rb,ya?ml}')]

    config.default_url_options = { host: ENV.fetch('HOST', 'localhost'), port: ENV.fetch('PORT', 3000) }
    routes.default_url_options = config.default_url_options
    config.action_mailer.default_url_options = config.default_url_options

    # config.view_component.generate.sidecar = true

    config.log_tags = [:uuid]
  end
end
