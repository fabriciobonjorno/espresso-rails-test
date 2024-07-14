# frozen_string_literal: true

module Api
  module V1
    module AuthServices
      module Logout
        class UseCase < MainService
          step :destroy_session

          def destroy_session(payload)
            session = JWTSessions::Session.new(payload: payload)
            session.flush_by_access_payload
            if session.present?
              Success(message: 'Logout realizado com sucesso!')
            else
              Failure(message: 'Não foi possivel realizar o logout')
            end
          end
        end
      end
    end
  end
end
