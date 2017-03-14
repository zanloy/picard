# frozen_string_literal: true
class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.belongs_to :list, index: true, foreign_key: true
      t.string :field
      t.string :operator
      t.string :value

      t.timestamps null: false
    end
  end
end
