class EventDispatcherService
  attr_reader :event

  def initialize event
    @event = event
  end

  def dispatch
    model, action = @event.name.split '-'
    klass = find_handler model
    Rails.logger.debug "Dispatching event #{@event.name} with class #{klass.inspect}"
    if klass
      handler = klass.new @event
      handler.public_send action if handler.respond_to? action
    end

    event.destroy if event && event.persisted?
  end

  def self.dispatch event
    new(event).dispatch
  end

  def find_handler model
    "#{model}EventHandler".safe_constantize
  end
end
