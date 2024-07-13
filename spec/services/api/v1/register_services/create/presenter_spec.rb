# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegisterServices::Create::Presenter do
  describe '.call' do
    let(:company) { create(:company) }
    let(:user) { create(:user, company: company) }

    it 'returns the correct response structure' do
      response = described_class.call(user)

      expect(response).to include(
        id: user.company.id,
        name: user.company.name,
        cnpj: user.company.cnpj,
        user: {
          email: user.email,
          name: user.name,
          role: user.role
        }
      )
    end
  end
end
