require 'rails_helper'

RSpec.describe UserChallengeEventHandler do
  describe '#created' do
    it 'creates an activity' do
      user_1 = Fabricate :user
      user_2 = Fabricate :user

      challenge = Fabricate :challenge, user: user_1
      user_1.join challenge

      events_count = Event.count
      activities_count = Activity.count

      user_2.join challenge
      expect(Event.count).to eq(events_count + 1)
      event = Event.order('created_at ASC').last

      handler = UserChallengeEventHandler.new event
      handler.created

      expect(Activity.count).to eq(activities_count + 2)
      a1, a2, = Activity.order('created_at').offset(activities_count)

      expect(a1.originator).to eq(user_2)
      expect(a1.subject).to eq(challenge)
      expect(a1.recipient).to eq(user_1)

      expect(a2.originator).to eq(user_2)
      expect(a2.subject).to eq(challenge)
      expect(a2.recipient).to eq(user_2)
    end
  end
end
