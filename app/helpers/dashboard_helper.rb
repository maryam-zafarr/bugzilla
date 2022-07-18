module DashboardHelper
  def manager_projects
    @projects = Project.where(manager_id: current_user.id)
  end

  def total_projects_bug
    @count = 0
    @projects = Project.where(manager_id: current_user.id)
    @projects.each do |project|
      @count += project.bugs.count
    end
    @total_count = @count.to_s.rjust(2, '0')
  end
end
