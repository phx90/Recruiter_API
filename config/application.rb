require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie" # Comente esta linha se não for usar Mailers
# require "action_mailbox/engine" # Comente esta linha se não for usar Mailbox
# require "action_text/engine"    # Comente esta linha se não for usar Action Text
# require "action_view/railtie"   # Comente esta linha para aplicações API-only
# require "action_cable/engine"   # Comente esta linha se não for usar Websockets
# require "sprockets/railtie"     # Comente esta linha para aplicações API-only
# require "rails/test_unit/railtie" # Comente esta linha se não for usar TestUnit

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RecruiterAPI
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Configuration to skip assets, helper, view, and other unnecessary files in generators
    config.generators do |g|
      g.assets false
      g.helper false
      g.view_specs false
      g.routing_specs false
    end
  end
end
