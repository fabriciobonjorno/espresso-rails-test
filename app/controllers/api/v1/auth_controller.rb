# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApiController
      skip_before_action :authorize_access_request!, only: [:login]

      def login
        Api::V1::AuthServices::Login::UseCase.call(params) do |on|
          on.failure(:validate_params) { |message| render json: message, status: :unprocessable_entity }
          on.failure(:find_user) { |message| render json: { message: message }, status: :unprocessable_entity }
          on.failure(:create_session) { |message| render json: { message: message }, status: :unprocessable_entity }
          on.failure(:output) { |message| render json: { message: message }, status: :internal_server_error }
          on.failure { |response| render json: response, status: :internal_server_error }
          on.success do |message, login_data|
            render json: { message: message, data: login_data }, status: :created
          end
        end
      end

      def logout
        Api::V1::AuthServices::Logout::UseCase.call(payload) do |on|
          on.failure { |response| render json: response, status: :internal_server_error }
          on.success { |response| render json: response, status: :ok }
        end
      end
    end
  end
end
