# frozen_string_literal: true

# Helper methods used across the application
module ApplicationHelper
  def manager?
    current_user.user_type == 'Manager'
  end

  def developer?
    current_user.user_type == 'Developer'
  end

  def qa?
    current_user.user_type == 'Quality Assurance Engineer'
  end

  def new?(bug)
    bug.status == 'New'
  end

  def started?(bug)
    bug.status == 'Started'
  end

  def resolved?(bug)
    bug.status == 'Resolved'
  end

  def completed?(bug)
    bug.status == 'Completed'
  end

  def bug?(bug)
    bug.bug_type == 'Bug'
  end

  def feature?(bug)
    bug.bug_type == 'Feature'
  end
end
