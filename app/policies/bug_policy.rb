class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize(user, bug)
    @user = user
    @bug = bug
  end

  def index?
    false
  end

  def show?
    (user.user_type == 'Quality Assurance Engineer' || (user.id).in?(bug.project.users.ids) ||  (user.id == bug.project.manager_id))
  end

  def new?
    user.user_type == 'Quality Assurance Engineer'
  end

  def create?
    user.user_type = 'Quality Assurance Engineer'
  end

  def edit?
    user.id == bug.reporter_id
  end

  def edit?
    user.id == bug.reporter_id || bug.assignee_id
  end

  def destroy?
    user.id == bug.reporter_id
  end

  def assign?
    (user.user_type == 'Developer') &&  ((user.id).in?(bug.project.users.ids))
  end
end
