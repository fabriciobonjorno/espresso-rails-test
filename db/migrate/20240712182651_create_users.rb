# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    return if table_exists? 'users'
    create_table :users do |t|
      t.string :name, null: false, default: '', index: true
      t.string :email, null: false, default: '', index: true
      t.string :password_digest
      t.integer :role
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
