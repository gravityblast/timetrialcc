class Challenge < ApplicationRecord
  include EventSourceable

  MAX_NUMBER_OF_USERS = 5

  class ChallengeAlreadyFullException < Exception; end

  belongs_to :user
  has_many   :user_challenges,    dependent: :destroy
  has_many   :users,              through: :user_challenges, source: :user
  has_many   :subjected_activity, as: :subject, class_name: 'Activity', dependent: :destroy
  has_many   :performed_activity, as: :subject, class_name: 'Activity', dependent: :destroy

  validates :user,         presence: true
  validates :name,         presence: true
  validates :segment_id,   presence: true
  validates :segment_name, presence: true
  validates :end_time,     presence: true

  def add user
    unless user.is_a? User
      raise TypeError.new('user must be a User object')
    end

    transaction do
      if user_challenges.count >= MAX_NUMBER_OF_USERS
        raise ChallengeAlreadyFullException.new
      end

      user_challenges.create user: user
    end
  end

  def end_time_formatted
    return '' unless end_time.is_a?(Time)
    end_time.strftime '%d/%m/%Y %H:%S %p'
  end

  def end_time_timestamp
    end_time ? end_time.to_f * 1000 : 0
  end

  def calculated!
    update_attribute :calculated, true
  end
end
