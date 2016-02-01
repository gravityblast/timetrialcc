require 'rails_helper'

RSpec.describe UserEventHandler do
  describe '#created' do
    it 'creates an activity' do
      user = Fabricate.build :user
      allow(user).to receive(:id).and_return(1)

      expect(User).to receive(:find_by).with(id: user.id).and_return(user)

      event = Event.new name: 'User-created', data: { id: user.id }
      handler = UserEventHandler.new event

      expected_activity_data = {
        recipient_id: user.id,
        event: event,
        event_name: 'User-created',
        subject: user,
        originator: user
      }

      expect(Activity).to receive(:create!).with(expected_activity_data)
      handler.created
    end
  end
end

