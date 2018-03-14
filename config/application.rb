require_relative 'boot'

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require 'carrierwave'
require 'carrierwave/orm/activerecord'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MoviesAdviser
  # Main Class
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths += Dir[ Rails.root.join('app', 'models', '**/') ]
    config.autoload_paths += Dir[ Rails.root.join('app', 'controllers', '**/') ]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
