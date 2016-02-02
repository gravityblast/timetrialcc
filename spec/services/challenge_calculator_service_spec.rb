require 'rails_helper'

RSpec.describe ChallengeCalculatorService do
  let(:user_1)    { Fabricate :user }
  let(:user_2)    { Fabricate :user }
  let(:challenge) { Fabricate :challenge, user: user_1 }

  before :each do
    user_1.join challenge
    user_2.join challenge
  end

  describe '#tt_users' do
    it 'returns an array of StravaTT::User' do
      calculator = ChallengeCalculatorService.new challenge, Time.now, Time.now
      users = calculator.tt_users

      expect(users.size).to eq(2)
      expect(users[0].id).to eq(user_1.id)
      expect(users[0].access_token).to eq(user_1.access_token)
      expect(users[1].id).to eq(user_2.id)
      expect(users[1].access_token).to eq(user_2.access_token)
    end
  end

  describe '#calculate!' do
    it "update challenge's times" do
      calculator = ChallengeCalculatorService.new challenge, Time.now, Time.now
      fake_tt    = double('StravaTT')
      allow(StravaTT).to receive(:new).and_return(fake_tt)

      user_efforts = [
        {
          user_id: user_1.id,
          effort: MiniStrava::Models::SegmentEffort.build('moving_time' => 10)
        },
        {
          user_id: user_2.id,
          effort: MiniStrava::Models::SegmentEffort.build('moving_time' => 5)
        }
      ]

      allow(fake_tt).to receive(:leaderboard).and_return(user_efforts)
      calculator.calculate!

      expect(challenge.reload.calculated?).to eq(true)

      user_challenge_1 = challenge.user_challenges.find_by user_id: user_1.id
      expect(user_challenge_1.moving_time).to eq(10)

      user_challenge_2 = challenge.user_challenges.find_by user_id: user_2.id
      expect(user_challenge_2.moving_time).to eq(5)
    end
  end
end

