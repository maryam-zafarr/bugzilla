# frozen_string_literal: true

# Bug Policy
class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize(user, bug)
    super
    @user = user
    @bug = bug
  end

  def show?
    (user.user_type == 'quality_assurance_engineer' || user.in?(bug.project.users) || user == bug.project.manager)
  end

  def new?
    user.user_type == 'quality_assurance_engineer'
  end

  def create?
    user.user_type = 'quality_assurance_engineer'
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
    (user.user_type == 'developer') && user.in?(bug.project.users)
  end

  def change?
    (user.user_type == 'developer') && user.in?(bug.project.users)
  end
end
