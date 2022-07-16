# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :user_type, presence: true

  has_many :manager_projects, class_name: 'Project', inverse_of: :manager, foreign_key: 'manager_id'
  has_and_belongs_to_many :projects, :uniq => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

end
