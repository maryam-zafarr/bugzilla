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
end
