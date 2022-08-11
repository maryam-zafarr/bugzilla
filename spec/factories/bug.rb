# frozen_string_literal: true

FactoryBot.define do
  factory :bug do
    title { Faker::App.name }
    bug_type { 'bug' }
    status { 'New' }
    deadline { '2022-07-28' }
    description { Faker::Movie.quote }
    screenshot { Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png') }
    association :project, factory: :project
    association :reporter, factory: :user, email: Faker::Internet.email, user_type: 'quality_assurance_engineer'
    association :assignee, factory: :user, email: Faker::Internet.email, user_type: 'developer'
  end
end
