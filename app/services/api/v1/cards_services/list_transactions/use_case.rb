# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module ListTransactions
        class UseCase < MainService
          step :validate_params
          step :find_transactions
          step :output

          def validate_params(params)
            transaction = params.last
            validation = Contract.new.call(transaction.permit!.to_h)
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def find_transactions(params)
            company = params.first.company
            transaction_params = params.last
            order = transaction_params[:order]&.to_sym || :desc
            if params.first.admin?
              find_transactions = company.statements.order(created_at: order)
            elsif params.first.member?
              find_transactions = params.first.statements.order(created_at: order)
            end

            return Failure(message: 'Você não tem transações cadastrados') if find_transactions.empty?

            Success(find_transactions)
          end

          def output(transactions)
            response = Presenter.call(transactions)
            if response
              Success(['Transações listadas com sucesso', response])
            else
              Failure(transactions.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
