# frozen_string_literal: true

module Api
  module V1
    module CardsServices
      module SendReceipt
        class Presenter < MainService
          include Rails.application.routes.url_helpers
          def self.call(statement, host)
            {
              cost: format_currency(statement.cost).to_f,
              transaction_id: statement.transaction_id,
              merchant: statement.merchant,
              status: statement.status,
              image_url: build_image_url(statement, host)
            }
          end

          def self.format_currency(currency)
            format('%.2f', (currency.to_f / 100.0))
          end

          def self.build_image_url(statement, host)
            asset_host = ActionController::Base.asset_host || 'http://localhost:3000'

            raise StandardError, "Invalid asset_host: #{asset_host}" unless asset_host.start_with?('http')

            asset_url = URI.join(asset_host, rails_blob_path(statement.receipt, only_path: true, host: host))
            asset_url.to_s
          end
        end
      end
    end
  end
end
