class Activity < ApplicationRecord
  belongs_to :event
  belongs_to :recipient,  class_name: 'User'
  belongs_to :subject,    polymorphic: true
  belongs_to :originator, polymorphic: true

  validates :event, presence: true
  validates :subject, presence: true
  validates :originator, presence: true

  def action
    "#{event_name.underscore}__#{subject_type.underscore}"
  end
end
