class Event < ApplicationRecord
  after_create :handle_event

  private

  def handle_event
    EventDispatcherService.delay.dispatch(self)
  end
end
