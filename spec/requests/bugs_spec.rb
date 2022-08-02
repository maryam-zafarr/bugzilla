# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bug', type: :request do
  before(:all) do
    @qa = create(:user, user_type: 'quality_assurance_engineer', email: Faker::Internet.email )
    @developer = create(:user, user_type: 'developer', email: Faker::Internet.email )
    @manager = create(:user, user_type: 'manager', email: Faker::Internet.email )
    @manager1 = create(:user, user_type: 'manager', email: Faker::Internet.email )
  end

  # Testing GET methods
  describe 'GET' do
    before(:all) do
      @project = create(:project, manager: @manager, users: [@developer, @qa])
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
      response.should redirect_to project_path(@project)
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

  # Testing DELETE methods
  describe 'DELETE' do
    before(:each) do
      @project = create(:project, manager: @manager, users: [@developer, @qa])
      @bug = create(:bug, project: @project, reporter: @qa, assignee: @developer)
    end

    it 'destroys the bug' do
      sign_in @qa
      expect {
        delete "/projects/#{@bug.project.id}/bugs/#{@bug.id}"
      }.to change(Bug, :count).by(-1)
    end

    it 'redirects to bugs#index' do
      sign_in @qa
      delete "/projects/#{@bug.project.id}/bugs/#{@bug.id}"
      response.should redirect_to project_bugs_path(@project)
    end
  end

  # describe 'Assignment' do
  #   before(:each) do
  #     @project = create(:project, manager: @manager, users: [@developer, @qa])
  #     @bug = create(:bug, project: @project, reporter: @qa)
  #   end
  #   it 'can assign bug if there is no assignee' do
  #     sign_in @developer
  #     @bug.update_column(:assignee_id, @developer.id)
  #     expect(@bug.reload.assignee_id).to eq(@developer.id)
  #   end
  # end
end
