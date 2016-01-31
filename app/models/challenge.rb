class Challenge < ApplicationRecord
  belongs_to :user

  validates :user,         presence: true
  validates :name,         presence: true
  validates :segment_id,   presence: true
  validates :segment_name, presence: true
  validates :end_time,     presence: true
end
