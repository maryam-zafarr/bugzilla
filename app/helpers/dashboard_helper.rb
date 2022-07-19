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

  def developer_projects
    @projects = current_user.projects
  end

  def developer_assigned_bugs
    @count = 0
    @projects = current_user.projects
    @projects.each do |project|
      project.bugs.each do |bug|
        if bug.assignee == current_user
          @count += 1
        end
      end
    end
    @total_count = @count.to_s.rjust(2, '0')
  end

  def total_reported_bugs
    @count = 0
    @projects = current_user.projects
    @projects.each do |project|
      project.bugs.each do |bug|
        if bug.reporter == current_user
          @count += 1
        end
      end
    end
    @total_count = @count.to_s.rjust(2, '0')
  end
end
