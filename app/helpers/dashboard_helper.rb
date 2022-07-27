# frozen_string_literal: true

# Helper methods for developer, manager and qa dashbaord statistics
module DashboardHelper
  def manager_projects
    Project.where(manager_id: current_user.id)
  end

  def total_projects_bug
    count = 0
    projects = Project.where(manager_id: current_user.id)
    projects.each do |project|
      count += project.bugs.count
    end
    count.to_s.rjust(2, '0')
  end

  def developer_projects
    current_user.projects.distinct
  end

  def developer_assigned_bugs
    count = 0
    projects = current_user.projects.distinct
    projects.each do |project|
      project.bugs.distinct.each do |bug|
        count += 1 if bug.assignee == current_user
      end
    end
    count.to_s.rjust(2, '0')
  end

  def total_reported_bugs
    count = 0
    projects = current_user.projects.distinct
    projects.each do |project|
      project.bugs.distinct.each do |bug|
        count += 1 if bug.reporter == current_user
      end
    end
    count.to_s.rjust(2, '0')
  end
end
