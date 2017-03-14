# frozen_string_literal: true
class CreateEnvironments < ActiveRecord::Migration[5.0]
  def change
    create_table :environments do |t|
      t.string :name, index: true, null: false
      t.string :domain, default: ''

      t.timestamps null: false
    end
  end
end
