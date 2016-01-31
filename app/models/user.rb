class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  #

  devise :omniauthable, omniauth_providers: [:strava]

  has_many :owned_challenges, dependent: :destroy
  has_many :user_challenges,  dependent: :destroy
  has_many :challenges,       through: :user_challenges

  def self.from_omniauth(auth)
    # byebug
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
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
end
