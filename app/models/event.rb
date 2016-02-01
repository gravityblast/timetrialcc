class Event < ApplicationRecord
  after_create :handle_event

  private

  def handle_event
    EventDispatchJob.perform_later self
  end
end
