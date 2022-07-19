# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :users, presence: true

  belongs_to :manager, class_name: 'User', inverse_of: :manager_projects, foreign_key: 'manager_id'
  has_and_belongs_to_many :users, optional: true
  has_many :bugs, dependent: :destroy
end
