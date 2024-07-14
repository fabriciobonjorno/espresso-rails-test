# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module List
        class Presenter < MainService
          def self.call(cards)
            cards.map { |card| card_map(card) }
          end

          def self.card_map(card)
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
