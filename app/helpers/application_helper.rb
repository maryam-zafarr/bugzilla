# frozen_string_literal: true

# Helper methods used across the application
module ApplicationHelper
  def manager?
    current_user.user_type == 'manager'
  end

  def developer?
    current_user.user_type == 'developer'
  end

  def qa?
    current_user.user_type == 'quality_assurance_engineer'
  end

  def new?(bug)
    bug.status == 'New'
  end

  def started?(bug)
    bug.status == 'Started'
  end

  def bug?(bug)
    bug.bug_type == 'bug'
  end

  def feature?(bug)
    bug.bug_type == 'feature'
  end
end
