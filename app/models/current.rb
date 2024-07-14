# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :company

  def self.set(user)
    self.user = user
    self.company = user.company if user.present? && user.company.present?
  end
end
