class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  # class Scope
  #   attr_reader :user, :scope, :project
  #   def initialize(user, scope, project)
  #     @user = user
  #     @scope = scope
  #     @project = project
  #   end

  #  def resolve
  #    if user.user_type == 'Quality Assurance Engineer'
  #      scope.all
  #    elsif user.user_type == 'Manager'
  #      scope.where(user: user.find(user.manager_id))
  #    else
  #     scope.where((user.id).in?(project.users.ids))
  #    end
  #  end
  # end

  def show?
    user.id == project.manager_id || (user.id).in?(project.users.ids) || user.user_type == 'Quality Assurance Engineer'
  end

  def new?
    user.user_type == 'Manager'
  end

  def create?
    @user.user_type = 'Manager'
  end

  def edit?
    user.id == project.manager_id
  end

  def update?
    user.id == project.manager_id
  end

  def destroy?
    user.id == project.manager_id
  end
end
