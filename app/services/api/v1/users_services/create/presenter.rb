# frozen_string_literal: true

module Api
  module V1
    module UsersServices
      module Create
        class Presenter < MainService
          def self.call(user)
            {
              email: user.email,
              name: user.name,
              role: user.role
            }
          end
        end
      end
    end
  end
end
