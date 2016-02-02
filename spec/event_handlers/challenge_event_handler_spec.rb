require 'rails_helper'

RSpec.describe ChallengeEventHandler do
  describe '#created' do
    it 'creates an activity' do
      user_1 = Fabricate :user
      user_2 = Fabricate :user
      challenge = Fabricate :challenge
      user_1.join challenge
      user_2.join challenge

      events_count = Event.count
      activities_count = Activity.count

      challenge.calculated!
      expect(Event.count).to eq(events_count + 1)

      event = Event.order(created_at: :asc).last
      EventDispatcherService.new(event).dispatch

      expect(Activity.count).to eq(activities_count + 2)
      activity_1, activity_2 = Activity.order(created_at: :asc).offset(activities_count)

      expect(activity_1.subject).to eq(challenge)
      expect(activity_1.recipient).to eq(user_1)

      expect(activity_2.subject).to eq(challenge)
      expect(activity_2.recipient).to eq(user_2)
    end
  end
end

