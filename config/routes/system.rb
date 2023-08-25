require 'sidekiq/web'
require 'sidekiq/cron/web'

# System routes

mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?
