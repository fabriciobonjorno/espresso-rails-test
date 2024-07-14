# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module Create
        class Presenter < MainService
          def self.call(card)
            {
              last4: card.last4,
              user: card.user.name
            }
          end
        end
      end
    end
  end
end
