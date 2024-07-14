# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Create
        class Presenter < MainService
          def self.call(category)
            {
              name: category.name
            }
          end
        end
      end
    end
  end
end
