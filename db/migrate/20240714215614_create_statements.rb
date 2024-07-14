# frozen_string_literal: true

class CreateStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :statements do |t|
      return if table_exists? 'statements'

      t.datetime :performed_at, index: true
      t.integer :cost, index: true
      t.string :transaction_id, index: true
      t.references :category, foreign_key: true
      t.references :card, foreign_key: true
      t.integer :status, default: 0, index: true
      t.string :merchant, index: true

      t.timestamps
    end
  end
end
