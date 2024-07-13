# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegisterController do
  describe 'POST #create' do
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
      it 'creates a new company and user' do
        expect do
          post '/api/v1/register', params: valid_params
        end.to change(Company, :count).by(1).and change(User, :count).by(1)

        json_response = response.parsed_body
        expect(response).to have_http_status(:created)
        expect(json_response['message']).to eq('Empresa cadastrada com sucesso')
        expect(json_response['data']['name']).to eq('Test Company')
        expect(json_response['data']['user']['name']).to eq('Test User')
      end
    end

    context 'with invalid params' do
      it 'returns an error' do
        post '/api/v1/register',
             params: { name: '', cnpj: '', user: { name: '', email: '', password: '', password_confirmation: '' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
