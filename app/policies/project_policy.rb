# frozen_string_literal: true

# Bug Policy
class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    super
    @user = user
    @project = project
  end

  def show?
    user == project.manager || user.in?(project.users) || user.user_type == 'Quality Assurance Engineer'
  end

  def new?
    user.user_type == 'Manager'
  end

  def create?
    @user.user_type = 'Manager'
  end

  def edit?
    user == project.manager
  end

  def update?
    user == project.manager
  end

  def destroy?
    user == project.manager
  end
end
