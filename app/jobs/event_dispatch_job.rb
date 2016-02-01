class EventDispatchJob < ApplicationJob
  queue_as :default

  def perform event
    EventDispatcherService.dispatch event
  end
end
