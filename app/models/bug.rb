# frozen_string_literal: true

# Class for projects' bug model
class Bug < ApplicationRecord
  enum bug_type: %i[bug feature]

  belongs_to :project
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', optional: true

  has_one_attached :screenshot, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :bug_type, presence: true
  validates :status, presence: true
  validates :deadline, presence: true
  validates :screenshot, content_type: { in: %w(image/png image/gif), message: 'Must be png or gif' }
end
