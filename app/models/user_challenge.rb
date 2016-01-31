class UserChallenge < ApplicationRecord
  belongs_to  :user
  belongs_to  :challenge

  validates :user,      presence: true
  validates :challenge, presence: true
  validates :user_id,   uniqueness: { scope: :challenge_id}
end
