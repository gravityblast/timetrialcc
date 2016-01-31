require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'validations' do
    it 'requires a user' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.user = nil
      expect(c).to_not be_valid
      expect(c.errors['user']).to be_present
    end

    it 'requires a name' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.name = nil
      expect(c).to_not be_valid
      expect(c.errors['name']).to be_present
    end

    it 'requires a segment_id' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.segment_id = nil
      expect(c).to_not be_valid
      expect(c.errors['segment_id']).to be_present
    end

    it 'requires a segment_name' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.segment_name = nil
      expect(c).to_not be_valid
      expect(c.errors['segment_name']).to be_present
    end

    it 'requires a end_time' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.end_time = nil
      expect(c).to_not be_valid
      expect(c.errors['end_time']).to be_present
    end
  end

  describe '#add' do
    context 'valid user' do
      it 'creates a UserChallenge with a user and challenge' do
        challenge = Fabricate :challenge
        expect(challenge.users.count).to eq(0)

        user = Fabricate :user
        expect(user.challenges.count).to eq(0)

        challenge.add(user)
        expect(user.challenges).to eq([challenge])
      end
    end

    context 'invalid user type' do
      it 'raises a TypeError exception' do
        challenge = Fabricate :challenge
        expect do
          challenge.add :foo
        end.to raise_error(TypeError)
      end
    end

    context 'challenge already full' do
      it 'raises a ChallengeAlreadyFullException' do
        challenge = Fabricate :challenge
        Challenge::MAX_NUMBER_OF_USERS.times do
          challenge.add Fabricate(:user)
        end

        expect do
          challenge.add Fabricate(:user)
        end.to raise_error(Challenge::ChallengeAlreadyFullException)
      end
    end
  end
end
