class User < ApplicationRecord
  include EventSourceable

  devise :omniauthable, omniauth_providers: [:strava]

  has_many :owned_challenges,     dependent: :destroy, class_name: 'Challenge'
  has_many :user_challenges,      dependent: :destroy
  has_many :challenges,           through: :user_challenges
  has_many :inbound_activities,   class_name: 'Activity', foreign_key: :recipient_id
  has_many :performed_activities, class_name: 'Activity', as: :originator, dependent: :destroy
  has_many :subjected_activities, class_name: 'Activity', as: :subject, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.access_token = auth.credentials.token
      user.email = auth.info.email
      user.name = auth.info.name
      user.profile_picture_url = auth.info.profile
    end
  end

  def join challenge
    unless challenge.is_a? Challenge
      raise TypeError.new('challenge must be a Challenge object')
    end

    challenge.add self
  end

  def joined challenge
    unless challenge.is_a? Challenge
      raise TypeError.new('challenge must be a Challenge object')
    end

    user_challenges.where(challenge_id: challenge.id).exists?
  end

  def strava_client
    MiniStrava::Client.new access_token
  end
end
