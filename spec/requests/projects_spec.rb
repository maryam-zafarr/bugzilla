# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Project', type: :request do
  before(:all) do
    @user = create(:user, user_type: 'manager', email: Faker::Internet.email)
  end

  # Testing GET methods
  describe 'GET' do
    it 'manager can render the :index view' do
      sign_in @user
      get projects_path
      expect(response).to render_template('index')
    end

    it 'developer can render the :index view' do
      @developer = create(:user, user_type: 'developer', email: Faker::Internet.email)
      sign_in @developer
      get projects_path
      expect(response).to render_template('index')
    end

    it 'qa can render all projects :index view' do
      @qa = create(:user, user_type: 'quality_assurance_engineer', email: Faker::Internet.email)
      sign_in @qa
      get '/all_projects'
      expect(response).to render_template('projects/all_projects_index')
    end

    it 'can render the :show view' do
      sign_in @user
      @project = create(:project, manager: @user)
      get project_path(@project)
      expect(response).to render_template('show')
    end

    it 'redirects to dashboard with error if project doesnt exist' do
      sign_in @user
      @project = create(:project, manager: @user)
      @project.destroy
      get project_path(@project)
      expect(response).to redirect_to dashboard_path
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
  end

  # Testing POST methods
  describe 'POST' do
    before(:each) do
      @developer = create(:user, user_type: 'developer')
      sign_in @user
    end
    it 'create a new project with valid attributes' do
      expect {
        post projects_path, params: { project: { title: 'Staggers Project', description: 'bbb',
                                                 user_ids: [@developer.id], manager_id: @user.id } }
      }.to change(Project, :count).by(1)
    end

    it 'does not create a project with invalid attributes' do
      post projects_path, params: { project: { title: nil, description: 'bbb', user_ids: [@developer.id],
                                               manager_id: @user.id } }
      expect(response).to render_template('new')
    end
  end

  # Testing PUT methods
  describe 'PUT' do
    before(:each) do
      @user1 = create(:user, user_type: 'developer')
      @project = create(:project, manager: @user, users: [@user1])
      sign_in @user
    end

    it 'updates project with valid attributes' do
      put "/projects/#{@project.id}", params: { project: { title: 'Vienna Project' } }
      @project.reload
      expect(@project.title).to eq('Vienna Project')
    end

    it 'does not update project with invalid attributes' do
      put "/projects/#{@project.id}", params: { project: { title: nil } }
      expect(response).to render_template('edit')
    end

    it 'redirects to updated project' do
      put "/projects/#{@project.id}", params: { project: { title: 'Tetra Vision' } }
      expect(response).to redirect_to project_path(@project)
    end
  end

  # Testing DELETE methods
  describe 'DELETE' do
    before(:each) do
      @project = create(:project, manager: @user)
      sign_in @user
    end

    it 'destroys the project' do
      expect {
        delete "/projects/#{@project.id}"
      }.to change(Project, :count).by(-1)
    end

    it 'redirects to projects#index' do
      delete "/projects/#{@project.id}"
      expect(response).to redirect_to projects_path
    end
  end
end
