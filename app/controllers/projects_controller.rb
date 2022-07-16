class ProjectsController < ApplicationController
  include Pundit
  before_action :set_project, only: %i[edit update show destory]
  before_action :authenticate_user!

  def index
    if current_user.user_type == 'Manager'
      @projects = Project.where(manager_id: current_user.id)
    else
      @projects = current_user.projects.distinct
    end
  end

  def show; end

  def new
    @project = current_user.projects.build
    authorize @project
  end

  def create
    @project = current_user.projects.build(project_params)
    users = User.find(params[:project][:user_ids])
    @project.users << users unless @project.users.include?(users)
    authorize @project

    respond_to do |format|
      if @project.save!
        format.html { redirect_to @project, notice: 'Project was sucessfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    @project.update(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was sucessfully updated.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Project was successfully destroyed' }
      format.json { head :no_content } # HTTP status code 200 with empty body
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :manager_id, user_ids: [])
  end
end
