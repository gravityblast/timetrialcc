module EventSourceable
  extend ActiveSupport::Concern

  included do
    after_create :event_sourceable_after_create
    after_update :event_sourceable_after_update, if: :changed?
    after_destroy :event_sourceable_after_destroy
  end

  def event_sourceable_after_create
    name = "#{self.class.name}-created"
    event_sourceable_create_event name, attributes
  end

  def event_sourceable_after_update
    name = "#{self.class.name}-updated"
    data = Hash[changes.collect { |key, values| [key, values.last] }]
    data[:id] = id if respond_to? :id
    event_sourceable_create_event name, data
  end

  def event_sourceable_after_destroy
    name = "#{self.class.name}-destroyed"
    event_sourceable_create_event name, attributes
  end

  def event_sourceable_create_event(name, data)
    Event.create name: name, data: data
  end
end
