# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Create
        class Presenter < MainService
          def self.call(user)
            {
              id: user.company.id,
              name: user.company.name,
              cnpj: user.company.cnpj,
              user: {
                email: user.email,
                name: user.name,
                role: user.role
              }
            }
          end
        end
      end
    end
  end
end
