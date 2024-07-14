# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[5.2]
  def change
    return if table_exists? 'cards'

    create_table :cards do |t|
      t.string :last4, null: false, default: '', index: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
