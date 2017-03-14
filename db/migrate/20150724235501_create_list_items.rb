# frozen_string_literal: true
class CreateListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :list_items do |t|
      t.belongs_to :list, index: true, foreign_key: true
      t.text :payload
      t.belongs_to :updated_by, class_name: User

      t.timestamps null: false
    end
  end
end
