# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Create
        class UseCase < MainService
          step :check_permission
          step :validate_params
          step :create
          step :output

          def check_permission(params)
            return Failure(message: 'Você não tem permissão para incluir categorias') unless params.first.admin?

            Success(params)
          end

          def validate_params(params)
            new_category = params.last
            validation = Contract.new.call(new_category.permit!.to_h)
            validation.success? ? Success(new_category) : Failure(validation.errors.to_h)
          end

          def create(params)
            category = Category.new(
              name: params[:name]
            )

            if category.save
              Success(category)
            else
              Failure(category.errors.full_messages.to_sentence)
            end
          end

          def output(category)
            response = Presenter.call(category)
            if response
              Success(['Categoria cadastrado com sucesso', response])
            else
              Failure(category.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
