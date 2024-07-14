# frozen_string_literal: true

FactoryBot.define do
  factory :sstatement do
    performed_at { '2024-07-14 17:56:14' }
    cost { 1 }
    transaction_id { 'MyString' }
    category { nil }
    card { nil }
  end
end
