# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[company_id] }, if: -> { will_save_change_to_name? }

  belongs_to :company, default: -> { Current.company }
end
