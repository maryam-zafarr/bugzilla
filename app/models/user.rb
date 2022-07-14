# frozen_string_literal: true

class User < ApplicationRecord
  has_many :manager_projects, class_name: 'Project', inverse_of: :manager, foreign_key: 'manager_id'
  has_and_belongs_to_many :projects, join_table: 'projects_users', foreign_key: 'project_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
