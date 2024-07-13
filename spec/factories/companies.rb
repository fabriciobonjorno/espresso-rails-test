# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    cnpj { Faker::Number.number(digits: 14) }

    before(:create) do |company|
      company.cnpj = CNPJ.generate
    end
  end
end
