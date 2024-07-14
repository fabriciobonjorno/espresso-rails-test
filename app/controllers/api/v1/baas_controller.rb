# frozen_string_literal: true

module Api
  module V1
    class BaasController < ApiController
      skip_before_action :authorize_access_request!, only: [:webhook]
      skip_before_action :set_current_user, only: [:webhook]

      def webhook
        handle_webhooks(params, params[:event_type])
      end

      private

      def handle_webhooks(params, event_type)
        case event_type
        when 'cards.transaction.approved'
          perform_create_statement(params)
        end
      end

      def perform_create_statement(params)
        card = Card.find_by(last4: params[:last4])
        Statement.create!(
          transaction_id: params[:transaction_id],
          merchant: params[:merchant],
          card_id: card.id,
          category_id: Category.first.id, # TODO: add method to find category based on the transaction
          cost: params[:cost],
          performed_at: params[:created_at]
        )
      end
    end
  end
end
