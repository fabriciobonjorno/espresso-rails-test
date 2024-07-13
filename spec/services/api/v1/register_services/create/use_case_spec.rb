# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegisterServices::Create::UseCase do
  subject { described_class.new }

  let(:valid_params) do
    {
      name: 'Test Company',
      cnpj: '12345678000195',
      user: {
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end

  describe '#call' do
    context 'with valid params' do
      it 'creates a new company and user' do
        params = ActionController::Parameters.new(valid_params)
        result = subject.call(params)
        expect(result).to be_success
      end
    end

    context 'with invalid params' do
      it 'returns validation errors' do
        invalid_params = ActionController::Parameters.new(name: '', cnpj: '',
                                                          user: { name: '', email: '', password: '', password_confirmation: '' })
        result = subject.call(invalid_params)
        expect(result).to be_failure
      end
    end
  end
end
