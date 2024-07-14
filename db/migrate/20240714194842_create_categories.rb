# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    return if table_exists? 'categories'

    create_table :categories do |t|
      t.string :name, null: false, default: '', index: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
