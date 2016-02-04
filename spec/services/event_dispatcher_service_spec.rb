require 'rails_helper'

class TestEventHandler < BaseEventHandler
  def created; end
end

RSpec.describe EventDispatcherService do
  describe '#dispatch' do
    it 'calls the event handler' do
      resource_attributes = { id: 1, name: :foo }
      event = Event.new name: 'Test-created', data: resource_attributes

      handler = TestEventHandler.new nil

      expect(TestEventHandler).to receive(:new).with(event).and_return(handler)
      expect(handler).to receive(:created)

      dispatcher = EventDispatcherService.new event
      dispatcher.dispatch
    end

    it 'destroy the event after dispatching it' do
      event = Event.create name: 'tmp', data: { foo: :bar }
      events_count = Event.count

      expect do
        EventDispatcherService.dispatch event
      end.to change(Event, :count).by(-1)
    end
  end
end

