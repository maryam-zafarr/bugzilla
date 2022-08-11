# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bug', type: :request do
  let!(:qa) { create(:user, user_type: 'quality_assurance_engineer', email: Faker::Internet.email) }
  let!(:developer) { create(:user, user_type: 'developer', email: Faker::Internet.email) }
  let!(:manager) { create(:user, user_type: 'manager', email: Faker::Internet.email) }
  let!(:manager1) { create(:user, user_type: 'manager', email: Faker::Internet.email) }
  let!(:project) { create(:project, manager: manager, users: [developer, qa]) }
  let(:bug) { create(:bug, project: project, reporter: qa, assignee: developer) }

  # Testing GET methods
  describe 'GET' do
    it 'can view bugs of projects he owns or is a part of' do
      sign_in manager
      get project_bugs_path(project)
      expect(response).to render_template('index')
      expect(response).to have_http_status(:success)
    end

    it 'cannot view bugs of projects he does not own or isnt part of' do
      sign_in manager1
      get project_bugs_path(project)
      expect(response).to redirect_to project_path(project)
      expect(response).to have_http_status(:redirect)
    end

    it 'can view a bug' do
      sign_in developer
      get project_bug_path(bug.project, bug)
      expect(response).to render_template('show')
      expect(response).to have_http_status(:success)
      expect(response.body).to include(bug.title, bug.bug_type, bug.status)
    end

    it 'qa can edit a bug' do
      sign_in qa
      get edit_project_bug_path(bug.project, bug)
      expect(response).to render_template('edit')
      expect(response).to have_http_status(:success)
    end

    it 'qa can initialize a new bug' do
      sign_in qa
      get new_project_bug_path(project)
      expect(response).to render_template('new')
      expect(response).to have_http_status(:success)
    end
  end

  # Testing POST methods
  describe 'POST' do
    before(:each) do
      sign_in qa
    end
    it 'creates a new bug with valid attributes' do
      expect {
        post project_bugs_path(project.id), params: { bug: { title: Faker::Verb.base, bug_type: 'bug', description: Faker::Lorem.sentence,
                                                              status: 'New', deadline: '2022-09-27', assignee_id: nil,
                                                              reporter_id: qa.id } }
      }.to change(Bug, :count).by(1)
      expect(assigns(:bug)).to eq(Bug.last)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to project_bug_path(project, Bug.last)
    end

    it 'does not create a bug with invalid attributes' do
      post project_bugs_path(project.id), params: { bug: { title: nil, bug_type: 'bug', description: Faker::Lorem.sentence,
                                                            status: 'New', deadline: '2022-09-27', assignee_id: nil,
                                                            reporter_id: qa.id } }
      expect(response).to render_template('new')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Testing PUT methods
  describe 'PUT' do
    before(:each) do
      sign_in qa
    end

    it 'updates bug with valid attributes' do
      patch project_bug_path(bug.project, bug), params: { bug: { title: 'Rendering Issue' } }
      bug.reload
      expect(bug.title).to eq('Rendering Issue')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to project_bug_path(project, bug)
    end

    it 'does not update bug with invalid attributes' do
      patch project_bug_path(bug.project, bug), params: { bug: { title: nil } }
      expect(response).to render_template('edit')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # Testing DELETE methods
  describe 'DELETE' do
    before(:each) do
      @bug = create(:bug, project: project, reporter: qa, assignee: developer)
      sign_in qa
    end

    it 'destroys the bug' do
      expect { delete project_bug_path(@bug.project, @bug) }.to change(Bug, :count).by(-1)
      expect(response).to redirect_to project_bugs_path(project)
      expect(response).to have_http_status(:redirect)
    end
  end

  # Testing bug assignment
  describe 'Assignment' do
    before(:each) do
      @bug = create(:bug, project: project, reporter: qa, assignee: nil)
    end

    it 'assigns bug if there is no assignee' do
      sign_in developer
      post project_bug_assign_path(@bug.project, @bug), params: { bug: { assignee_id: developer.id } }
      @bug.reload
      expect(@bug.assignee_id).to eq(developer.id)
      expect(response).to have_http_status(:redirect)
    end
  end

  # Testing bug status change
  describe 'Status' do
    before(:each) do
      @bug_new = create(:bug, project: project, reporter: qa, assignee: developer, status: 'New')
      @bug_started = create(:bug, project: project, reporter: qa, assignee: developer, status: 'Started')
      @feature_started = create(:bug, project: project, reporter: qa, assignee: developer, status: 'Started',
                                      bug_type: 'feature')
      sign_in developer
    end

    it 'changes to started if new' do
      post project_bug_change_path(@bug_new.project, @bug_new), params: { bug: { status: 'Started' } }
      @bug_new.reload
      expect(@bug_new.status).to eq('Started')
      expect(response).to have_http_status(:redirect)
    end

    it 'changes to completed if started and feature' do
      post project_bug_change_path(@feature_started.project, @feature_started), params: { bug: { status: 'Completed' } }
      @feature_started.reload
      expect(@feature_started.status).to eq('Completed')
      expect(response).to have_http_status(:redirect)
    end

    it 'changes to resolved if started and bug' do
      post project_bug_change_path(@bug_started.project, @bug_started), params: { bug: { status: 'Resolved' } }
      @bug_started.reload
      expect(@bug_started.status).to eq('Resolved')
      expect(response).to have_http_status(:redirect)
    end
  end
end
