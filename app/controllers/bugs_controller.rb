# frozen_string_literal: true

# Bug class to add bugs/ features to projects
class BugsController < ApplicationController
  before_action :set_bug, only: %i[edit update destroy show]
  before_action :set_project, only: %i[index new create edit]
  before_action :set_bug_id, only: %i[assign change]
  before_action :authorize_bug, except: %i[index create new]

  def index
    if qa? || current_user.in?(@project.users) || (current_user == @project.manager)
      @bugs = @project.bugs
    else
      redirect_to project_path(@project)
    end
  end

  def new
    @bug = @project.bugs.new
    authorize @bug
  end

  def create
    @bug = @project.bugs.create(bug_params)
    authorize @bug
    if @bug.save
      redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bug.update(bug_params)
    if @bug.save
      redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bug.destroy
    redirect_to project_bugs_path, notice: 'Bug was sucessfully deleted.'
  end

  def assign
    if @bug.assignee_id.nil?
      assignee = User.find(current_user.id).id
      @bug.update_column(:assignee_id, assignee)
    end
    redirect_back(fallback_location: project_bug_path(@bug.project, @bug))
  end

  def change
    if new?(@bug)
      @bug.update_column(:status, 'Started')
    elsif  started?(@bug) && bug?(@bug)
      @bug.update_column(:status, 'Resolved')
    elsif  started?(@bug) && feature?(@bug)
      @bug.update_column(:status, 'Completed')
    else
      @bug.update_column(:status, 'Started')
    end
    redirect_back(fallback_location: project_bug_path(@bug.project, @bug))
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def set_bug_id
    @bug = Bug.find(params[:bug_id])
  end

  def authorize_bug
    authorize @bug
  end

  def bug_params
    params.require(:bug).permit(:title, :bug_type, :description, :screenshot,
                                :status, :deadline, :assignee_id, :reporter_id)
  end
end
