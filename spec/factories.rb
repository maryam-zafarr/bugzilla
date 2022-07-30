# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Henry Bill' }
    email { 'henry.bill@example.com' }
    password { '123456' }
    user_type { 'manager' }
  end

  factory :project do
    title { 'Project Neon' }
    description { 'This project aims to develop an ecommerce platform' }
    association :manager, factory: :user
    before(:create) do |project|
      project.users = build_list :user, 1, name: 'John Doe', email: 'john.doe@example.com', user_type: 'developer'
    end
  end

  factory :bug do
  end
end
