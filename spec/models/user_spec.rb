# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user, email: 'ella@example.com')
  end

  # Tests for Validations
  context 'validation tests' do
    it 'is valid with valid attributes' do
      expect(@user1).to be_valid
    end

    it 'is invalid without a unique email' do
      user2 = build(:user, name: 'Bob')
      expect(user2).to_not be_valid
    end

    it 'is not valid without a name' do
      @user1.name = nil
      expect(@user1).to_not be_valid
    end

    it 'is not valid without an email' do
      @user1.email = nil
      expect(@user1).to_not be_valid
    end

    it 'is not valid without a password' do
      @user1.password = nil
      expect(@user1).to_not be_valid
    end

    it 'is not valid without a user_type' do
      @user1.user_type = nil
      expect(@user1).to_not be_valid
    end
  end

  # Tests for Associations
  context 'association tests' do
    it { is_expected.to have_many(:manager_projects).class_name('Project').dependent(:destroy) }
    it { is_expected.to have_and_belong_to_many(:projects) }
    it { is_expected.to have_many(:bugs).through(:projects) }
  end

  # Tests for Column Specifications
  context 'column specifications' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:user_type).of_type(:integer) }
    it { is_expected.to have_db_index(:email) }
  end

  # Test for model instance methods
  it 'should display name with title' do
    expect(@user1.name_with_title).to eq('Henry Bill (manager)')
  end
end
