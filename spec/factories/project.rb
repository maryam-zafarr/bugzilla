# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { Faker::Game.title }
    description { Faker::Movie.quote }
    association :manager, factory: :user
    users { [create(:user)] }
  end
end
