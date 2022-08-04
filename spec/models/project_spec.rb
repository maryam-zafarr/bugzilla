# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:all) do
    @project1 = create(:project)
  end

  # Tests for Validations
  context 'validation tests' do
    it 'is valid with valid attributes' do
      expect(@project1).to be_valid
    end

    it 'is not valid without a title' do
      project2 = build(:project, title: nil)
      expect(project2).to_not be_valid
    end

    it 'is not valid without a description' do
      project2 = build(:project, description: nil)
      expect(project2).to_not be_valid
    end

    it 'is not valid without users' do
      project2 = build(:project, users: [])
      expect(project2).to_not be_valid
    end

    it 'is not valid without a manager' do
      project2 = build(:project, manager_id: nil)
      expect(project2).to_not be_valid
    end
  end

  # Tests for Associations
  context 'association tests' do
    it { should belong_to(:manager).class_name('User').with_foreign_key(:manager_id) }
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:bugs).dependent(:destroy) }
  end

  # Tests for Column Specifications
  context 'column specifications' do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:manager_id).of_type(:integer) }
    it { should have_db_index(:manager_id) }
  end
end
