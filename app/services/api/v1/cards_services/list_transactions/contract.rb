# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module ListTransactions
        class Contract < ApplicationContract
          params do
            optional(:order).value(:string)
          end
        end
      end
    end
  end
end
