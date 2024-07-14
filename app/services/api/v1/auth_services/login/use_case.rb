# frozen_string_literal: true

module Api
  module V1
    module AuthServices
      module Login
        class UseCase < MainService
          step :validate_params
          step :find_user
          step :create_session
          step :output

          def validate_params(params)
            validation = Contract.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def find_user(params)
            user = User.find_by(email: params[:email])
            if user
              Success(user: user, params: params)
            else
              Failure('Credenciais inválidas!')
            end
          end

          def create_session(params)
            user_params = params[:params]
            user = params[:user]
            if user&.authenticate(user_params[:password])
              payload = { user_id: user.id }
              session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
              token = session.login
              Success(token)
            else
              Failure('Erro ao iniciar sessão!')
            end
          end

          def output(token)
            response = Presenter.call(token)
            if response
              Success(['Login realizado com sucesso', response])
            else
              Failure(token.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
