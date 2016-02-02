class UserChallenge < ApplicationRecord
  include EventSourceable

  belongs_to  :user
  belongs_to  :challenge
  has_many   :subjected_activity, as: :subject, class_name: 'Activity', dependent: :destroy
  has_many   :performed_activity, as: :subject, class_name: 'Activity', dependent: :destroy

  validates :user,      presence: true
  validates :challenge, presence: true
  validates :user_id,   uniqueness: { scope: :challenge_id}
end
