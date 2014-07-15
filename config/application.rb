require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module NikolaWorkshops
  class Application < Rails::Application
    config.assets.paths << "#{Rails.root}/app/assets/fonts"

    config.assets.precompile += %w(admin.js admin.css)

    config.i18n.available_locales = %w(en ru)
    config.i18n.default_locale = 'ru'

    config.time_zone = 'Moscow'
  end
end
