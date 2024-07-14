# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module Create
        class UseCase < MainService
          step :check_permission
          step :validate_params
          step :find_user
          step :create
          step :output

          def check_permission(params)
            return Failure(message: 'Você não tem permissão para incluir cartões') unless params.first.admin?

            Success(params)
          end

          def validate_params(params)
            new_card = params.last
            validation = Contract.new.call(new_card.permit!.to_h)
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def find_user(params)
            user = params.first
            card_params = params.last

            find_user = User.find_by(id: card_params[:user_id])
            return Failure(message: 'Usuário não encontrado') unless find_user

            valid_user = user.company.users.include?(find_user)
            return Failure(message: 'Usuário não cadastrado na empresa') unless valid_user

            Success(card_params)
          end

          def create(params)
            card = Card.new(
              last4: params[:last4],
              user_id: params[:user_id]
            )

            if card.save
              Success(card)
            else
              Failure(card.errors.full_messages.to_sentence)
            end
          end

          def output(card)
            response = Presenter.call(card)
            if response
              Success(['Cartão cadastrado com sucesso', response])
            else
              Failure(card.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
