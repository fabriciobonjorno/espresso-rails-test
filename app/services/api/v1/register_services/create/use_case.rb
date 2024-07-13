# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Create
        class UseCase < MainService
          step :validate_params
          step :create
          step :output

          def validate_params(params)
            validation = Contract.new.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def create(params)
            params[:user][:role] = 0
            company = Company.new(
              name: params[:name],
              cnpj: params[:cnpj]
            )
            user = company.users.build(params[:user])

            if company.save
              Success([company, user])
            else
              Failure([company.errors.full_messages.to_sentence, user.errors.full_messages.to_sentence])
            end
          end

          def output(result)
            _, user = result
            response = Presenter.call(user)
            if response
              Success(['Empresa cadastrada com sucesso', response])
            else
              Failure(user.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
