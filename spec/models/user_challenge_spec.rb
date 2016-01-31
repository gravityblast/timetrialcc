require 'rails_helper'

RSpec.describe UserChallenge, type: :model do
  describe 'validations' do
    it 'requires a user' do
      uc = Fabricate :user_challenge
      expect(uc).to be_valid

      uc.user = nil
      expect(uc).to_not be_valid
      expect(uc.errors['user']).to be_present
    end

    it 'requires a challenge' do
      uc = Fabricate :user_challenge
      expect(uc).to be_valid

      uc.challenge = nil
      expect(uc).to_not be_valid
      expect(uc.errors['challenge']).to be_present
    end

    it 'requires a unique pair of user_id and challenge_id' do
      uc_1 = Fabricate :user_challenge
      expect(uc_1).to be_valid

      # same user, different challenge
      uc_2 = Fabricate.build :user_challenge, user: uc_1.user
      expect(uc_2).to be_valid

      # same challenge, different user
      uc_3 = Fabricate.build :user_challenge, challenge: uc_1.challenge
      expect(uc_3).to be_valid

      # same user and challenge
      uc_4 = Fabricate.build :user_challenge, user: uc_1.user, challenge: uc_1.challenge
      expect(uc_4).to_not be_valid
      expect(uc_4.errors['user_id']).to be_present
    end
  end
end
