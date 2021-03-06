# frozen_string_literal: true
class CreateServers < ActiveRecord::Migration[5.0]
  def change
    create_table :servers do |t|
      t.string :name, null: false
      t.belongs_to :environment, index: true, foreign_key: true
      t.string :ip_address
      t.string :ports
      t.string :api_key, index: true, unique: true

      t.timestamps null: false
    end
  end
end
