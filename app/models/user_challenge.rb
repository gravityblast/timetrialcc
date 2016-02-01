class UserChallenge < ApplicationRecord
  include EventSourceable

  belongs_to  :user
  belongs_to  :challenge
  has_many    :activity, as: :subject

  validates :user,      presence: true
  validates :challenge, presence: true
  validates :user_id,   uniqueness: { scope: :challenge_id}
end
