require 'active_support/core_ext/integer/time'

# rubocop:disable Metrics/BlockLength
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  if ENV.key?('HOST')
    config.hosts << ENV.fetch('HOST')

    config.force_ssl = true
  end

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :redis_cache_store, config.redis_config
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
    config.session_store :cache_store, key: ENV.fetch('SESSION_KEY', '_coderoso'), compress: true,
                                       pool_size: 5, expire_after: 1.year
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :letter_opener_web
  config.action_mailer.perform_caching = false
  config.action_mailer.preview_path = Rails.root.join('spec/mailers/previews')

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  config.web_console.whitelisted_ips = Socket.ip_address_list.reduce([]) do |result, address|
    address.ipv4? ? result << IPAddr.new(address.ip_address).mask(24) : result
  end

  config.after_initialize do
    Bullet.enable = true
    Bullet.raise = true
  end
end
# rubocop:enable Metrics/BlockLength