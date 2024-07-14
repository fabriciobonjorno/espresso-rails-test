# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthController do
  describe 'POST #login' do
    let(:user) do
      FactoryBot.create(:user, email: 'user@example.com', password: 'password123', password_confirmation: 'password123')
    end

    context 'with valid credentials' do
      let(:valid_params) { { email: 'user@example.com', password: 'password123' } }

      before do
        allow(User).to receive(:find_by).and_return(user)
        allow_any_instance_of(JWTSessions::Session).to receive(:login).and_return(
          csrf: 'csrf_token',
          access: 'access_token',
          refresh: 'refresh_token'
        )
      end

      it 'returns a successful response with login data' do
        post '/api/v1/login', params: valid_params

        response_body = response.parsed_body
        expect(response).to have_http_status(:created)
        expect(response_body).to include(
          'message' => anything,
          'data' => {
            'csrf' => 'csrf_token',
            'access_token' => 'access_token',
            'refresh_token' => 'refresh_token'
          }
        )
      end
    end

    context 'with invalid credentials' do
      let(:invalid_params) do
        { email: 'invalid_user@example.com', password: 'wrong_password', password_confirmation: 'wrong_password' }
      end

      it 'returns an unprocessable entity response' do
        post '/api/v1/login', params: invalid_params

        response_body = response.parsed_body
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body).to eq('message' => 'Credenciais inválidas!')
      end
    end
  end

  describe 'DELETE #logout' do
    let(:user) do
      FactoryBot.create(:user, email: 'user@example.com', password: 'password123', password_confirmation: 'password123')
    end
    let(:access_token) { 'valid_access_token' }

    before do
      allow(User).to receive(:find_by).and_return(user)
      allow_any_instance_of(JWTSessions::Session).to receive(:login).and_return(
        csrf: 'csrf_token',
        access: access_token,
        refresh: 'refresh_token'
      )
    end

    context 'when logged in' do
      before do
        post '/api/v1/login', params: { email: 'user@example.com', password: 'password123' }
        @response_body = response.parsed_body
      end

      it 'returns a successful response with logout message' do
        delete '/api/v1/logout', headers: { 'Authorization' => "Bearer #{@response_body['data']['access_token']}" }

        expect(response).to have_http_status(:ok)
        expect(json_response['message']).to eq('Logout realizado com sucesso!')
      end
    end

    context 'when not logged in' do
      it 'returns an unauthorized response' do
        delete '/api/v1/logout'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
