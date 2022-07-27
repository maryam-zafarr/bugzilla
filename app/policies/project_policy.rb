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
    user == project.manager || user.in?(project.users) || user.user_type == 'quality_assurance_engineer'
  end

  def new?
    user.user_type == 'manager'
  end

  def create?
    @user.user_type = 'manager'
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

  def all_projects_index?
    user.user_type == 'quality_assurance_engineer'
  end
end
