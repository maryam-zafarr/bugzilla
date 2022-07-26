# frozen_string_literal: true

# Class to perform CRUD operations for projects
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[edit update destroy]

  def index
    @projects = if manager?
                  @projects = Project.where(manager_id: current_user.id)
                else
                  current_user.projects.distinct
                end
  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  def new
    @project = current_user.projects.build
    authorize @project
  end

  def create
    @project = current_user.projects.build(project_params)
    add_to_team(@project) if params[:user_ids].present?
    authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was sucessfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @project
  end

  def update
    @project.update(project_params)
    authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was sucessfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    authorize @project

    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Project was successfully deleted' }
      format.json { head :no_content } # HTTP status code 200 with empty body
    end
  end

  def all_projects_index
    @projects = Project.all
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :manager_id, user_ids: [])
  end
end
