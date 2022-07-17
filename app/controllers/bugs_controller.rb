# frozen_string_literal: true

# Bug class to add bugs/ features to projects
class BugsController < ApplicationController
  before_action :set_bug, only: %i[edit update show destory]
  before_action :authenticate_user!

  def index
    @project = Project.find(params[:project_id])
    @bugs = @project.bugs
  end

  def show; end

  def new
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new
  end

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.create(bug_params)

    @bug.assignee = User.find(params[:bug][:assignee_id])

    respond_to do |format|
      if @bug.save!
        format.html { redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    @bug.update(bug_params)
    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bug.destroy

    respond_to do |format|
      format.html { redirect_to @project, notice: 'Bug was sucessfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_bug
    @project = Project.find(params[:project_id])
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :bug_type, :status, :deadline, :assignee_id, :reporter_id)
  end
end
