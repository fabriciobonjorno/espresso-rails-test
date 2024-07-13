# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:name).filled(:string)
            required(:cnpj).filled(:string)
            required(:user).hash do
              required(:name).filled(:string)
              required(:email).filled(:string, format?: /@/)
              required(:password).filled(:string)
              required(:password_confirmation).filled(:string)
              optional(:role).value(:integer)
            end
          end
        end
      end
    end
  end
end
