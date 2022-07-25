# frozen_string_literal: true

# Bug Policy
class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize(user, bug)
    super
    @user = user
    @bug = bug
  end

  def index?
    false
  end

  def show?
    (user.user_type == 'Quality Assurance Engineer' || user.in?(bug.project.users) || user == bug.project.manager)
  end

  def new?
    user.user_type == 'Quality Assurance Engineer'
  end

  def create?
    user.user_type = 'Quality Assurance Engineer'
  end

  def edit?
    user == bug.reporter || bug.assignee
  end

  def update?
    user == bug.reporter || bug.assignee
  end

  def destroy?
    user == bug.reporter
  end

  def assign?
    (user.user_type == 'Developer') && user.in?(bug.project.users)
  end
end
