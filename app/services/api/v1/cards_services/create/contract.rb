# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:last4).filled(:string)
            required(:user_id).filled(:integer)
          end
        end
      end
    end
  end
end
