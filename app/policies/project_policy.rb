class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # some piece of code
  end

  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def new?
    user.user_type == 'Manager'
  end

  def create?
    @user.user_type = 'Manager'
  end

  def edit?
    user.user_type == 'Manager'
  end

  def update?
    user.user_type == 'Manager'
  end

  def destroy?
    user.user_type == 'Manager'
  end
end
