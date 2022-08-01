# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Project', type: :request do
    before(:all) do
      @user = create(:user, email: 'maryam.zafar@devsinc.com', user_type: 'manager')
    end

    # Testing GET methods
    it 'can render the :index view' do
      sign_in @user
      get projects_path
      expect(response).to render_template('index')
    end

    it 'can render the :show view' do
      sign_in @user
      @project = create(:project, manager: @user)
      get project_path(@project)
      expect(response).to render_template('show')
    end

    it 'can render the :edit view' do
      sign_in @user
      @project = create(:project, manager: @user)
      get edit_project_path(@project)
      expect(response).to render_template('edit')
    end

    it 'can initialize a new project' do
      sign_in @user
      get new_project_path
      expect(response).to render_template('new')
    end

    # Testing POST methods
    it 'can create a project'

    # Testing PUT methods
    it 'can update a project'

    # Testing DELETE methods
    describe 'DELETE' do
      before(:each) do
        @project = create(:project, manager: @user)
      end

      it 'destroys the project' do
        sign_in @user
        expect {
          delete "/projects/#{@project.id}"
        }.to change(Project, :count).by(-1)
      end

      it 'redirects to projects#index' do
        delete "/projects/#{@project.id}"
        response.should redirect_to projects_path
      end
    end
end

  # , params: { id: @project }

