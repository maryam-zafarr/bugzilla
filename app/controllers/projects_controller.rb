# frozen_string_literal: true

# Class to perform CRUD operations for projects
class ProjectsController < ApplicationController
  before_action :initialize_project, only: :new
  before_action :set_project, only: %i[edit update destroy show]
  before_action :authorize_project, except: %i[index all_projects_index create]

  def index
    @projects = if manager?
                  @projects = Project.where(manager_id: current_user.id)
                else
                  current_user.projects.distinct
                end
  end

  def create
    @project = current_user.projects.build(project_params)
    add_to_team(@project) if params[:user_ids].present?
    authorize @project
    if @project.save
      redirect_to @project, notice: 'Project was sucessfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @project.update(project_params)
    if @project.save
      redirect_to @project, notice: 'Project was sucessfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted'
  end

  def all_projects_index
    @projects = Project.all
  end

  private

  def authorize_project
    authorize @project
  end

  def initialize_project
    @project = current_user.projects.build
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :manager_id, user_ids: [])
  end
end
