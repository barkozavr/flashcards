require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module Flashcards
  class Application < Rails::Application
    config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"
    config.load_defaults 6.0
    config.i18n.default_locale = :ru
  end
end
