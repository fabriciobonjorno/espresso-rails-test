# frozen_string_literal: true

module Api
  module V1
    module UsersServices
      module Create
        class UseCase < MainService
          step :check_permission
          step :validate_params
          step :create
          step :output

          def check_permission(params)
            return Failure(message: 'Você não tem permissão para incluir usuários') unless params.first.admin?

            Success(params)
          end

          def validate_params(params)
            new_user = params.last
            validation = Contract.new.call(new_user.permit!.to_h)
            validation.success? ? Success(new_user) : Failure(validation.errors.to_h)
          end

          def create(params)
            user = User.new(
              name: params[:name],
              email: params[:email],
              role: params[:role],
              password: params[:password],
              password_confirmation: params[:password_confirmation]
            )

            if user.save
              Success(user)
            else
              Failure(user.errors.full_messages.to_sentence)
            end
          end

          def output(user)
            response = Presenter.call(user)
            if response
              Success(['Usuário cadastrado com sucesso', response])
            else
              Failure(user.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
