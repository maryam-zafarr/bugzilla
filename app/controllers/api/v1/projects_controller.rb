# frozen_string_literal: true

# Class to perform CRUD operations for projects
module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :initialize_project, only: :new
      before_action :set_project, only: %i[edit update destroy show]
      before_action :authorize_project, only: %i[new show edit update destroy]

      def index
        @projects = if manager?
                      @projects = Project.where(manager_id: current_user.id)
                    else
                      current_user.projects.distinct
                    end
        render json: @projects
      end

      def show
        render json: @project
      end

      def create
        @project = current_user.projects.build(project_params)
        authorize @project
        if @project.save
          render json: @project
        else
          render json: { error: 'Unable to save project' }
        end
      end

      def update
        @project.update(project_params)
        if @project.save
          render json: @project
        else
          render json: { error: 'Unable to update project' }
        end
      end

      def destroy
        @project.destroy
      end

      def all_projects_index
        @projects = Project.all
        authorize @projects
        render json: @projects
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
  end
end
