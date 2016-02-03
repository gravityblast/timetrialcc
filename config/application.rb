require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require File.expand_path('../../lib/mini_strava_extensions', __FILE__)

class RailsStdoutLogging::StdoutLogger
  def broadcast_messages *args; end
end

module Timetrial
  class Application < Rails::Application
    config.active_job.queue_adapter = :queue_classic
  end
end
