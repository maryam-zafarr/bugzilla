# frozen_string_literal: true

# Class for user bug model
class User < ApplicationRecord
  enum user_type: %i[manager developer quality_assurance_engineer]

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :user_type, presence: true

  has_many :manager_projects, class_name: 'Project', inverse_of: :manager, foreign_key: 'manager_id',
                              dependent: :destroy
  has_and_belongs_to_many :projects

  has_many :bugs, through: :projects

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :timeoutable

  def name_with_title
    "#{name} (#{user_type})"
  end
end
