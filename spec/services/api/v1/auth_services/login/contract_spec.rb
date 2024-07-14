# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthServices::Login::Contract do
  describe 'Contract validation' do
    it 'validates the presence of email and password' do
      contract = described_class.new

      result = contract.call(email: 'user@example.com', password: 'password123')

      expect(result).to be_success
    end

    it 'requires email to be present' do
      contract = described_class.new

      result = contract.call(email: nil, password: 'password123')

      expect(result).to be_failure
      expect(result.errors[:email]).to include('must be a string')
    end

    it 'requires password to be present' do
      contract = described_class.new

      result = contract.call(email: 'user@example.com', password: nil)

      expect(result).to be_failure
      expect(result.errors[:password]).to include('must be a string')
    end
  end
end
