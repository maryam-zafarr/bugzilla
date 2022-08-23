# frozen_string_literal: true

# Class to perform CRUD operations for projects
module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :initialize_project, only: :new
      before_action :set_project, only: %i[edit update destroy show]
      skip_before_action :verify_authenticity_token

      def index
        @projects = Project.all
        render json: @projects.to_json(include: %i[manager users bugs])
      end

      def show
        render json: @project.to_json(include: %i[manager users bugs])
      end

      def create
        @project = current_user.projects.build(project_params)
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
        render json: @projects
      end

      private

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
