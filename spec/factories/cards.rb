# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    last4 { Faker::Business.credit_card_number }
    association :user
  end
end
