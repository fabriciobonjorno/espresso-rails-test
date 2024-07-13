# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    return if table_exists? 'companies'
    create_table :companies do |t|
      t.string :name, null: false, default: '', index: true
      t.string :cnpj, null: false, default: '', index: true

      t.timestamps
    end
  end
end
