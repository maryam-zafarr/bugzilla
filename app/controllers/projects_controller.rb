class ProjectsController < ApplicationController
  before_action :set_project, only: %i[edit update destroy]

  def index
    if current_user.user_type == 'Manager'
      @projects = Project.where(manager_id: current_user.id)
    elsif current_user.user_type == 'Quality Assurance Engineer'
      @all_projects = Project.all
      @projects = current_user.projects.distinct
    else
      @projects = current_user.projects.distinct
    end
    session[:projects] = @projects
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

  def edit
    authorize @project
  end

  def update
    @project.update(project_params)
    authorize @project
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
