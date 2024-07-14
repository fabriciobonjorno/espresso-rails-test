# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthServices::Login::UseCase do
  describe '#call' do
    let(:user_params) do
      ActionController::Parameters.new(email: 'user@example.com', password: 'password123',
                                       password_confirmation: 'password123')
    end
    let(:user) do
      FactoryBot.create(:user, email: 'user@example.com', password: 'password123', password_confirmation: 'password123')
    end

    it 'logs in successfully with valid credentials' do
      allow(User).to receive(:find_by).and_return(user)
      allow_any_instance_of(JWTSessions::Session).to receive(:login).and_return(
        csrf: 'csrf_token',
        access: 'access_token',
        refresh: 'refresh_token'
      )

      result = described_class.new.call(user_params)

      expect(result).to be_success
      expect(result.value!).to include(
        csrf: 'csrf_token',
        access_token: 'access_token',
        refresh_token: 'refresh_token'
      )
    end

    it 'fails to log in with invalid credentials' do
      invalid_params = ActionController::Parameters.new(email: 'invalid_user@example.com', password: 'wrong_password')

      result = described_class.new.call(invalid_params)

      expect(result).to be_failure
      expect(result.failure).to eq('Credenciais inválidas!')
    end
  end
end
