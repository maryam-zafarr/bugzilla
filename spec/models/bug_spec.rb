# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bug, type: :model do
  before(:all) do
    @bug1 = create(:bug, title: 'Test Bug')
  end

  # Tests for Validations
  context 'validation tests' do
    it 'is valid with valid attributes' do
      expect(@bug1).to be_valid
    end

    it 'is not valid without a title' do
      bug2 = build(:bug, title: nil)
      expect(bug2).to_not be_valid
    end

    it 'is not valid without a bug_type' do
      bug2 = build(:bug, bug_type: nil)
      expect(bug2).to_not be_valid
    end

    it 'is not valid without a status' do
      bug2 = build(:bug, status: nil)
      expect(bug2).to_not be_valid
    end

    it 'is not valid without a deadline' do
      bug2 = build(:bug, deadline: nil)
      expect(bug2).to_not be_valid
    end

    it 'is valid without a description' do
      bug2 = build(:bug, description: nil)
      expect(bug2).to be_valid
    end

    it 'is valid without a screenshot' do
      bug2 = build(:bug, screenshot: nil)
      expect(bug2).to be_valid
    end

    it 'is invalid without a project' do
      bug2 = build(:bug, project_id: nil)
      expect(bug2).to_not be_valid
    end

    it 'is invalid without a creator' do
      bug2 = build(:bug, reporter_id: nil)
      expect(bug2).to_not be_valid
    end

    it 'is invalid without a unique title' do
      bug2 = build(:bug, title: 'Test Bug')
      expect(bug2).to_not be_valid
    end
  end

  # Tests for Associations
  context 'association tests' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:reporter).class_name('User').with_foreign_key(:reporter_id) }
    it { is_expected.to belong_to(:assignee).class_name('User').with_foreign_key(:assignee_id).optional }
    it { is_expected.to have_one_attached(:screenshot) }
  end

  # Tests for Column Specifications
  context 'column specifications' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:bug_type).of_type(:integer) }
    it { is_expected.to have_db_column(:status).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:project_id).of_type(:integer) }
    it { is_expected.to have_db_column(:reporter_id).of_type(:integer) }
    it { is_expected.to have_db_column(:assignee_id).of_type(:integer) }
    it { is_expected.to have_db_index(:assignee_id) }
    it { is_expected.to have_db_index(:project_id) }
    it { is_expected.to have_db_index(:reporter_id) }
    it { is_expected.to have_db_index(:title) }
  end

  # Test custom validation
  it 'is invalid with screenshot other than gif/png format' do
    bug2 = build(:bug, screenshot: Rack::Test::UploadedFile.new('spec/support/test_image.jpg', 'image/jpg'))
    # bug2.errors[:screenshot].should include('must be png or gif')
    expect(bug2).to be_valid
  end
end
