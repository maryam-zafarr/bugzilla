# frozen_string_literal: true

# Bug class to add bugs/ features to projects
module Api
  module V1
    class BugsController < ApplicationController
      before_action :set_bug, only: %i[edit update destroy show]
      before_action :set_project, only: %i[index new create edit]
      before_action :initialize_bug, only: :new
      before_action :set_bug_id, only: %i[assign change]

      def index
        @bugs = @project.bugs
        render json: @bugs.to_json(include: %i[reporter assignee])
      end

      def show
        if !@bug.screenshot.attached?
          render json: @bug.as_json(include: %i[reporter assignee project])
        else
          render json: @bug.as_json(include: %i[reporter assignee project]).merge(screenshot_path: url_for(@bug.screenshot))
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
      end

      def assign
        if @bug.assignee_id.nil?
          @bug.assignee_id = current_user.id
          @bug.save
        end
        render json: @bug
      end

      def change
        if new?(@bug)
          @bug.status = 'Started'
        elsif  started?(@bug) && bug?(@bug)
          @bug.status = 'Resolved'
        elsif  started?(@bug) && feature?(@bug)
          @bug.status = 'Completed'
        end
        @bug.save
        render json: @bug
      end

      private

      def set_project
        @project = Project.find(params[:project_id])
      end

      def initialize_bug
        @bug = @project.bugs.new
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
  end
end
