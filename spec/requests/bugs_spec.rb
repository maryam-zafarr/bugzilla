# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bug', type: :request do
  before(:all) do
    @qa = create(:user, user_type: 'quality_assurance_engineer', email: Faker::Internet.email)
    @developer = create(:user, user_type: 'developer', email: Faker::Internet.email)
    @manager = create(:user, user_type: 'manager', email: Faker::Internet.email)
    @manager1 = create(:user, user_type: 'manager', email: Faker::Internet.email)
    @project = create(:project, manager: @manager, users: [@developer, @qa])
  end

  # Testing GET methods
  describe 'GET' do
    before(:all) do
      @bug = create(:bug, project: @project, reporter: @qa, assignee: @developer)
    end

    it 'can view bugs of projects he owns or is a part of' do
      sign_in @manager
      get project_bugs_path(@project)
      expect(response).to render_template('index')
    end

    it 'cannot view bugs of projects he does not own or isnt part of' do
      sign_in @manager1
      get project_bugs_path(@project)
      expect(response).to redirect_to project_path(@project)
    end

    it 'can view a bug' do
      sign_in @developer
      get project_bug_path(@bug.project, @bug)
      expect(response).to render_template('show')
    end

    it 'qa can edit a bug' do
      sign_in @qa
      get edit_project_bug_path(@bug.project, @bug)
      expect(response).to render_template('edit')
    end

    it 'qa can initialize a new bug' do
      sign_in @qa
      get new_project_bug_path(@project)
      expect(response).to render_template('new')
    end
  end

  # Testing POST methods
  describe 'POST' do
    before(:each) do
      sign_in @qa
    end
    it 'creates a new bug with valid attributes' do
      expect {
        post "/projects/#{@project.id}/bugs", params: { bug: { title: 'a', bug_type: 'bug', description: 'b',
                                                               status: 'New', deadline: '2022-09-27', assignee_id: nil,
                                                               reporter_id: @qa.id } }
      }.to change(Bug, :count).by(1)
    end

    it 'does not create a bug with invalid attributes' do
      post "/projects/#{@project.id}/bugs", params: { bug: { title: nil, bug_type: 'bug', description: 'bbb',
                                                             status: 'New', deadline: '2022-09-27', assignee_id: nil,
                                                             reporter_id: @qa.id } }
      expect(response).to render_template('new')
    end
  end

  describe 'PUT' do
    before(:each) do
      @bug = create(:bug, project: @project, reporter: @qa, assignee: @developer)
      sign_in @qa
    end

    it 'updates bug with valid attributes' do
      put "/projects/#{@project.id}/bugs/#{@bug.id}", params: { bug: { title: 'Rendering Issue' } }
      @bug.reload
      expect(@bug.title).to eq('Rendering Issue')
    end

    it 'does not update bug with invalid attributes' do
      put "/projects/#{@project.id}/bugs/#{@bug.id}", params: { bug: { title: nil } }
      expect(response).to render_template('edit')
    end

    it 'redirects to updated bug' do
      put "/projects/#{@project.id}/bugs/#{@bug.id}", params: { bug: { title: 'Layout issue' } }
      expect(response).to redirect_to project_bug_path(@project, @bug)
    end
  end

  # Testing DELETE methods
  describe 'DELETE' do
    before(:each) do
      @bug = create(:bug, project: @project, reporter: @qa, assignee: @developer)
      sign_in @qa
    end

    it 'destroys the bug' do
      expect {
        delete "/projects/#{@bug.project.id}/bugs/#{@bug.id}"
      }.to change(Bug, :count).by(-1)
    end

    it 'redirects to bugs#index' do
      delete "/projects/#{@bug.project.id}/bugs/#{@bug.id}"
      expect(response).to redirect_to project_bugs_path(@project)
    end
  end

  # Testing bug assignment to developer
  describe 'Assignment' do
    before(:each) do
      @bug = create(:bug, project: @project, reporter: @qa, assignee: nil)
    end

    it 'assigns bug if there is no assignee' do
      sign_in @developer
      post "/projects/#{@project.id}/bugs/#{@bug.id}/assign", params: { bug: { assignee_id: @developer.id } }
      @bug.reload
      expect(@bug.assignee_id).to eq(@developer.id)
    end
  end

  # Testing bug status change
  describe 'Status' do
    before(:each) do
      @bug_new = create(:bug, project: @project, reporter: @qa, assignee: @developer, status: 'New')
      @bug_started = create(:bug, project: @project, reporter: @qa, assignee: @developer, status: 'Started')
      @feature_started = create(:bug, project: @project, reporter: @qa, assignee: @developer, status: 'Started', bug_type: 'feature')
      sign_in @developer
    end

    it 'changes to started if new' do
      post "/projects/#{@project.id}/bugs/#{@bug_new.id}/change", params: { bug: { status: 'Started' } }
      @bug_new.reload
      expect(@bug_new.status).to eq('Started')
    end

    it 'changes to completed if started and feature' do
      post "/projects/#{@project.id}/bugs/#{@feature_started.id}/change", params: { bug: { status: 'Completed' } }
      @feature_started.reload
      expect(@feature_started.status).to eq('Completed')
    end

    it 'changes to resolved if started and bug' do
      post "/projects/#{@project.id}/bugs/#{@bug_started.id}/change", params: { bug: { status: 'Resolved' } }
      @bug_started.reload
      expect(@bug_started.status).to eq('Resolved')
    end
  end
end
