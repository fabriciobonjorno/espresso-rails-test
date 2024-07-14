# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module List
        class UseCase < MainService
          step :validate_params
          step :find_cards
          step :output

          def validate_params(params)
            card = params.last
            validation = Contract.new.call(card.permit!.to_h)
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def find_cards(params)
            company = params.first.company
            card_params = params.last
            order = card_params[:order]&.to_sym || :desc
            if params.first.admin?
              find_cards = company.cards.order(created_at: order)
            elsif params.first.member?
              find_cards = params.first.cards.order(created_at: order)
            end

            return Failure(message: 'Você não tem cartões cadastrados') if find_cards.empty?

            Success(find_cards)
          end

          def output(cards)
            response = Presenter.call(cards)
            if response
              Success(['Cartões listados com sucesso', response])
            else
              Failure(cards.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
