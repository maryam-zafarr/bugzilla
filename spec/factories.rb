# frozen_string_literal: true

FactoryBot.define do
  factory :bug do

  end

  factory :project do

  end

  factory :user do
    name { 'Henry Bill' }
    email { 'henry.bill@example.com' }
    password { '123456' }
    user_type { 'manager' }
  end
end
