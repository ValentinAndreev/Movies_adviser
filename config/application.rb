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
    config.load_defaults 5.1
    config.autoload_paths += Dir[ Rails.root.join('app', 'models', '**/') ]
    config.autoload_paths += Dir[ Rails.root.join('app', 'controllers', '**/') ]
    config.autoload_paths += Dir[ Rails.root.join('app', 'presenters', '**/') ]

    config.generators do |generate|
      generate.helper true
      generate.helper_specs true
      generate.javascript_engine false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.view_specs false
      generate.controller_spec true
      generate.test_framework :rspec
    end
  end
end
