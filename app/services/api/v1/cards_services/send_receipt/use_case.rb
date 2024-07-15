# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module SendReceipt
        class UseCase < MainService
          step :validate_params
          step :find_transactions
          step :output

          def validate_params(params)
            validation = Contract.new.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def find_transactions(params)
            statement = Statement.find(params['id'])
            statement.status = :sent_receipt
            statement.receipt = params[:receipt] # aqui salvar a minha imagem
            statement.save!

            return Failure(message: 'Você não tem transações cadastrados') if statement.nil?

            Success(statement)
          end

          def output(statement)
            response = Presenter.call(statement, 'localhost:3000')
            if response
              Success(['Comprovante anexado com sucesso', response])
            else
              Failure(transactions.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
