# frozen_string_literal: true

# Class for user bug model
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :user_type, presence: true

  has_many :manager_projects, class_name: 'Project', inverse_of: :manager, foreign_key: 'manager_id'
  has_and_belongs_to_many :projects, uniq: true

  has_many :bugs, through: :projects

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def name_with_title
    "#{name} (#{user_type})"
  end
end
