# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Project', type: :request do
  let!(:user) { create(:user, user_type: 'manager', email: Faker::Internet.email) }
  let(:project) { create(:project, manager: user) }
  let(:developer) { create(:user, user_type: 'developer') }

  # Testing GET methods
  describe 'GET' do
    it 'displays a list of all manager projects' do
      sign_in user
      get projects_path
      expect(response).to render_template('index')
      expect(response).to have_http_status(:success)
    end

    it 'displays a list of all projects assigned to developer' do
      sign_in developer
      get projects_path
      expect(response).to render_template('index')
      expect(response).to have_http_status(:success)
    end

    it 'displays a list of all projects assigned to qa' do
      @qa = create(:user, user_type: 'quality_assurance_engineer')
      sign_in @qa
      get all_projects_path
      expect(response).to render_template('projects/all_projects_index')
      expect(response).to have_http_status(:success)
    end

    it 'can view project details' do
      sign_in user
      get project_path(project)
      expect(response).to render_template('show')
      expect(response).to have_http_status(:success)
      expect(response.body).to include(project.title)
    end

    it 'redirects to dashboard with error if project doesnt exist' do
      sign_in user
      project.destroy
      get project_path(project)
      expect(response).to redirect_to dashboard_path
      expect(response).to have_http_status(:redirect)
    end

    it 'can edit a project' do
      sign_in user
      get edit_project_path(project)
      expect(response).to render_template('edit')
      expect(response).to have_http_status(:success)
    end

    it 'can initialize a new project' do
      sign_in user
      get new_project_path
      expect(response).to render_template('new')
      expect(response).to have_http_status(:success)
    end
  end

  # Testing POST methods
  describe 'POST' do
    before(:each) do
      sign_in user
    end
    it 'create a new project with valid attributes' do
      expect {
        post projects_path, params: { project: { title: Faker::Lorem.word, description: Faker::Lorem.sentence,
                                                 user_ids: [developer.id], manager_id: user.id } }
      }.to change(Project, :count).by(1)
      expect(assigns(:project)).to eq(Project.last)
      expect(response).to redirect_to project_path(Project.last)
      expect(response).to have_http_status(:redirect)
    end

    it 'does not create a project with invalid attributes' do
      post projects_path, params: { project: { title: nil, description: Faker::Lorem.sentence, user_ids: [developer.id],
                                               manager_id: user.id } }
      expect(response).to render_template('new')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Testing PUT methods
  describe 'PUT' do
    before(:each) do
      sign_in user
    end

    it 'updates project with valid attributes' do
      patch project_path(project), params: { project: { title: 'Vienna Project' } }
      project.reload
      expect(project.title).to eq('Vienna Project')
      expect(response).to redirect_to project_path(project)
      expect(response).to have_http_status(:redirect)
    end

    it 'does not update project with invalid attributes' do
      patch project_path(project), params: { project: { title: nil } }
      expect(response).to render_template('edit')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Testing DELETE methods
  describe 'DELETE' do
    before(:each) do
      sign_in user
      @project = create(:project, manager: user)
    end

    it 'destroys the project' do
      expect { delete project_path(@project) }.to change(Project, :count).by(-1)
      expect(response).to redirect_to projects_path
      expect(response).to have_http_status(:redirect)
    end
  end
end
