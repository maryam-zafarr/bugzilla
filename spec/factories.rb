# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Henry Bill' }
    email { Faker::Internet.email }
    password { '123456' }
    user_type { 'manager' }
  end

  factory :project do
    title { Faker::Game.title }
    description { 'This project aims to develop an ecommerce platform' }
    association :manager, factory: :user
    users { [create(:user)] }
  end

  factory :bug do
    title { Faker::App.name }
    bug_type { 'bug' }
    status { 'New' }
    deadline { '2022-07-28' }
    description { 'Whenever an item is added to the cart, the cart shows two of those items.' }
    screenshot { Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png') }
    association :project, factory: :project
    association :reporter, factory: :user, name: 'Marilyn Monroe', email: 'marilyn.monroe@example.com', user_type: 'quality_assurance_engineer'
    association :assignee, factory: :user, name: 'Devin Brook', email: 'devin.brook@example.com', user_type: 'developer'
  end
end
