# frozen_string_literal: true

# Class for projects' bug model
class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', optional: true

  has_one_attached :screenshot, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :bug_type, presence: true
  validates :status, presence: true
  validates :deadline, presence: true
  validate :correct_image_type

  def correct_image_type
    return unless screenshot.attached? && !screenshot.content_type.in?(%w[image/png image/gif])

    errors.add(:screenshot, 'must be png or gif')
  end
end
