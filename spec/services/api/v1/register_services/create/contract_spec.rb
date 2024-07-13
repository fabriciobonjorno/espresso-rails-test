# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegisterServices::Create::Contract do
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

  context 'with valid params' do
    it 'passes validation' do
      result = subject.call(valid_params)
      expect(result).to be_success
    end
  end

  context 'with invalid params' do
    it 'fails validation' do
      result = subject.call(name: '', cnpj: '', user: { name: '', email: '', password: '', password_confirmation: '' })
      expect(result).to be_failure
    end
  end
end
