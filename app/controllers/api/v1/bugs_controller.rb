# frozen_string_literal: true

# Bug class to add bugs/ features to projects
module Api
  module V1
    class BugsController < ApplicationController
      before_action :set_bug, only: %i[edit update destroy show]
      before_action :set_project, only: %i[index new create edit]
      before_action :initialize_bug, only: :new

      def index
        @bugs = @project.bugs
        render_json(@bugs)
      end

      def show
        if !@bug.screenshot.attached?
          render_json(@bug)
        else
          render json: @bug.as_json(include: %i[reporter assignee project screenshot])
        end
      end

      def create
        @bug = @project.bugs.create(bug_params)
        if @bug.save
          render json: @bug
        else
          render json: { error: 'Unable to create bug.' }
        end
      end

      def update
        @bug.update(bug_params)
        if @bug.save
          render json: @bug
        else
          render json: { error: 'Unable to update bug.' }
        end
      end

      def destroy
        @bug.destroy
        if @bug.errors.any?
          render json: { error: 'Unable to delete this bug.' }
        else
          render json: { message: 'Bug is successfully deleted' }
        end
      end

      private

      def render_json(object)
        render json: object.as_json(include: %i[reporter assignee project])
      end

      def set_project
        @project = Project.find(params[:project_id])
      end

      def initialize_bug
        @bug = @project.bugs.new
      end

      def set_bug
        @bug = Bug.find(params[:id])
      end

      def bug_params
        params.require(:bug).permit(:title, :bug_type, :description, :screenshot,
                                    :status, :deadline, :assignee_id, :reporter_id)
      end
    end
  end
end
