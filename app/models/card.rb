# frozen_string_literal: true

class Card < ApplicationRecord
  validates :last4, presence: true
  validates :last4, uniqueness: { case_sensitive: false, scope: %i[user_id] }, if: -> { will_save_change_to_last4? }

  belongs_to :user
end
