# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user1) { create(:user, email: 'maryam.zafar@devsinc.com') }

  # Tests for Validations
  context 'validation tests' do
    it 'is valid with valid attributes' do
      expect(user1).to be_valid
    end

    it 'is invalid without a unique email' do
      user2 = build(:user, email: 'maryam.zafar@devsinc.com', name: 'Em Z')
      expect(user2).to_not be_valid
    end

    it 'is not valid without a name' do
      user2 = build(:user, name: nil)
      expect(user2).to_not be_valid
    end

    it 'is not valid without an email' do
      user2 = build(:user, email: nil)
      expect(user2).to_not be_valid
    end

    it 'is not valid without a password' do
      user2 = build(:user, password: nil)
      expect(user2).to_not be_valid
    end

    it 'is not valid without a user_type' do
      user2 = build(:user, user_type: nil)
      expect(user2).to_not be_valid
    end
  end

  # Tests for Associations
  context 'association tests' do
    it { should have_many(:manager_projects).class_name('Project').dependent(:destroy) }
    it { should have_and_belong_to_many(:projects) }
    it { should have_many(:bugs).through(:projects) }
  end

  # Tests for Column Specifications
  context 'column specifications' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:user_type).of_type(:integer) }
    it { should have_db_index(:email) }
  end

  # Test for model instance methods
  it 'should display name with title' do
    expect(user1.name_with_title).to eq("#{user1.name} (#{user1.user_type})")
  end

  # Test for Enums
  it { should define_enum_for(:user_type).with(%i[manager developer quality_assurance_engineer]) }
end
