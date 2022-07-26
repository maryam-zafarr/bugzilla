# frozen_string_literal: true

# Bug class to add bugs/ features to projects
class BugsController < ApplicationController
  before_action :set_bug, only: %i[edit update destroy show]
  before_action :set_project, only: %i[index new create edit]
  before_action :set_bug_id, only: %i[assign change]

  def index
    if qa? || current_user.in?(@project.users) || (current_user == @project.manager)
      @bugs = @project.bugs
    else
      redirect_to project_path(@project)
    end
  end

  def show
    authorize @bug
  end

  def new
    @bug = @project.bugs.new
    authorize @bug
  end

  def create
    @bug = @project.bugs.create(bug_params)
    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @bug
  end

  def update
    @bug.update(bug_params)
    authorize @bug
    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bug.destroy
    authorize @bug

    respond_to do |format|
      format.html { redirect_to project_bugs_path, notice: 'Bug was sucessfully deleted.' }
      format.json { head :no_content }
    end
  end

  def assign
    authorize @bug
    if @bug.assignee_id.nil?
      assignee = User.find(current_user.id).id
      @bug.update(:assignee_id, assignee)
    end
    redirect_back(fallback_location: project_bug_path(@bug.project, @bug))
  end

  def change
    if new?(@bug)
      @bug.update(:status, 'Started')
    elsif  started?(@bug) && bug?(@bug)
      @bug.update(:status, 'Resolved')
    elsif  started?(@bug) && feature?(@bug)
      @bug.update(:status, 'Completed')
    else
      @bug.update(:status, 'Started')
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

  def bug_params
    params.require(:bug).permit(:title, :bug_type, :description, :screenshot,
                                :status, :deadline, :assignee_id, :reporter_id)
  end
end
