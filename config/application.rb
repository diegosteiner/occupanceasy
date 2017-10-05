# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Occupanceasy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << Rails.root.join('app/resources')
    config.autoload_paths << Rails.root.join('/app/services')

    # Only loads a smaller set of middleware suitable for API only apps.
    config.api_only = true

    # Middleware like session, flash, cookies can be added back manually.

    # Skip views, helpers and assets when generating a new resource.

    config.generators do |generator|
      generator.test_framework :rspec
    end

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :methods => [:get, :put, :patch, :options],
          :max_age => 15
      end
    end
  end
end
