# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    user_type { 'manager' }
  end
end
