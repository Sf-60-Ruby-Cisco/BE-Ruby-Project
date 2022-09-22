require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CarDiary
  class Application < Rails::Application
 
    config.load_defaults 7.0    
    config.active_storage.variant_processor = :mini_magick
    config.generators.system_tests = nil
    config.active_job.queue_adapter = :sidekiq
    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc
    config.generators do |g|
      g.template_engine :slim
    end
    config.i18n.available_locales = [:en, :bg]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
  end
end
