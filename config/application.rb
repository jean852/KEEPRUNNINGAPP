require_relative "boot"

require "rails/all"
require "money-rails"
# require "sidekiq/scheduler"
# require "sidekiq"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KEEPRUNNINGAPP
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

# Sidekiq.configure_server do |config|
#   schedule_file = "config/schedule.yml"
#   if File.exist?(schedule_file)
#     Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
#   end
# end
