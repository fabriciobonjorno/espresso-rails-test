# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, :email, :password, :password_confirmation, :role, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :company, default: -> { Current.company }
  has_many :cards, dependent: :destroy

  enum role: { admin: 0, member: 1 }

  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end
end
