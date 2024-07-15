# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module ListTransactions
        class Presenter < MainService
          def self.call(transactions)
            transactions.map { |transaction| transaction_map(transaction) }
          end

          def self.transaction_map(transaction)
            {
              cost: format_currency(transaction.cost).to_f,
              transaction_id: transaction.transaction_id,
              merchant: transaction.merchant,
              status: transaction.status
            }
          end

          def self.format_currency(currency)
            format('%.2f', (currency.to_f / 100.0))
          end
        end
      end
    end
  end
end
