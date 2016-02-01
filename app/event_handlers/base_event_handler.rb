class BaseEventHandler
  attr_reader :event

  def initialize event
    @event = event
  end

  private

  def create_activity originator:, recipient:, event:, subject:
    data = {
      recipient_id: recipient.try(:id),
      event: event,
      event_name: event.name,
      subject: subject,
      originator: originator,
      event_created_at: event.created_at
    }

    activity = Activity.create! data
    activity
  end
end
