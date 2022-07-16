# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User', inverse_of: :manager_projects, foreign_key: 'manager_id'
  has_and_belongs_to_many :users, :uniq => true

  accepts_nested_attributes_for :users
end
