# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Beer.brand }
    association :company
  end
end
