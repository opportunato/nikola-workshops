Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = true
  config.assets.digest = true

  config.assets.paths << "#{Rails.root}/app/assets/fonts"
  config.assets.version = '1.0'

  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  config.log_level = :info
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  config.active_record.dump_schema_after_migration = false
end
