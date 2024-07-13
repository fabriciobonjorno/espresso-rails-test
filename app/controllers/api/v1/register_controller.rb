# frozen_string_literal: true

module Api
  module V1
    class RegisterController < ApiController
      def create
        Api::V1::RegisterServices::Create::UseCase.call(params.to_unsafe_h) do |on|
          on.failure(:validate_params) { |message| render json: message, status: :unprocessable_entity }
          on.failure(:create) { |message| render json: { message: message }, status: :unprocessable_entity }
          on.failure(:output) { |message| render json: { message: message }, status: :internal_server_error }
          on.failure { |response| render json: response, status: :internal_server_error }
          on.success do |message, user_data|
            render json: { message: message, data: user_data }, status: :created
          end
        end
      end
    end
  end
end
