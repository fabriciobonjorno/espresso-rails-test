# frozen_string_literal: true

class Company < ApplicationRecord
  before_validation :clean_cnpj
  validates :name, :cnpj, presence: true
  validates :cnpj, uniqueness: { case_sensitive: false }
  validate :valid_cnpj
  has_many :users, dependent: :destroy

  def clean_cnpj
    self.cnpj = cnpj.gsub(/[^\d]/, '') if attribute_present?('cnpj')
  end

  def valid_cnpj
    errors.add(:cnpj, 'CNPJ inválido, verifique e tente novamente') unless CNPJ.valid?(cnpj)
  end
end
