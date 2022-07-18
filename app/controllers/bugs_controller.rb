# frozen_string_literal: true

# Bug class to add bugs/ features to projects
class BugsController < ApplicationController
  before_action :set_bug, only: %i[edit update destory]
  before_action :authenticate_user!


  def index
    @project = Project.find(params[:project_id])
    if (current_user.user_type == 'Quality Assurance Engineer' || (current_user.id).in?(@project.users.ids) || (current_user.id == @project.manager_id))
      @bugs = @project.bugs
    else
      redirect_to project_path(@project)
    end
  end

  def show
    @bug = Bug.find(params[:id])
    authorize @bug
  end

  def new
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new
    authorize @bug
  end

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.create(bug_params)

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

  def edit
    authorize @bug
  end

  def update
    @bug.update(bug_params)
    authorize @bug
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
    authorize @bug

    respond_to do |format|
      format.html { redirect_to @project, notice: 'Bug was sucessfully deleted.' }
      format.json { head :no_content }
    end
  end

  def assign
    @bug = Bug.find(params[:bug_id])
    authorize @bug
    if @bug.assignee_id.nil?
      assignee = User.find(current_user.id).id
      @bug.update_column(:assignee_id, assignee)
    else
      redirect_to project_bug_path(@bug.project, @bug), flash: { notice: 'Bug already has an assignee' }
    end
  end

  def change
    @bug = Bug.find(params[:bug_id])
    if @bug.status == 'New'
      @bug.update_column(:status, 'Started')
    else
      @bug.update_column(:status, 'Resolved')
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
