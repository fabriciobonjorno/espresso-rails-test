# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :category
  belongs_to :card

  has_one_attached :receipt

  enum status: { open: 0, comproved: 1, esc_verification: 2, sent_receipt: 3 }
end
