# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company do
  subject { build(:company) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cnpj) }
  it { is_expected.to validate_uniqueness_of(:cnpj).case_insensitive }
  it { is_expected.to have_many(:users).dependent(:destroy) }

  describe 'callbacks' do
    it 'cleans the CNPJ before validation' do
      company = build(:company, cnpj: '12.345.678/0001-95')
      company.validate
      expect(company.cnpj).to eq('12345678000195')
    end
  end

  describe '#valid_cnpj' do
    it 'adds an error if the CNPJ is invalid' do
      company = build(:company, cnpj: '12345678901234')
      company.validate
      expect(company.errors[:cnpj]).to include('CNPJ inválido, verifique e tente novamente')
    end

    it 'does not add an error if the CNPJ is valid' do
      company = build(:company)
      allow(CNPJ).to receive(:valid?).and_return(true)
      company.validate
      expect(company.errors[:cnpj]).to be_empty
    end
  end
end
