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

  def new?
    @bug.status == 'New'
  end

  def started?
    @bug.status == 'Started'
  end

  def resolved?
    @bug.status == 'Resolved'
  end

  def completed?
    @bug.status == 'Completed'
  end

  def bug?
    @bug.bug_type == 'Bug'
  end

  def feature?
    @bug.bug_type == 'Feature'
  end
end
