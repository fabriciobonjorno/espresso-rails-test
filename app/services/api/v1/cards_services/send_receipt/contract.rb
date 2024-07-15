# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module SendReceipt
        class Contract < ApplicationContract
          params do
            required(:id).filled(:integer)
          end
        end
      end
    end
  end
end
