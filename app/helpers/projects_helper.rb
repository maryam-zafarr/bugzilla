# frozen_string_literal: true

# Helper methods for project creation
module ProjectsHelper
  def add_to_team
    users = User.find(params[:project][:user_ids])
    @project.users << users unless @project.users.include?(users)
  end
end
