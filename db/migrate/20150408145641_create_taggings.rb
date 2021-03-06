# frozen_string_literal: true
class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.references :taggable, polymorphic: true, index: true, null: false
      t.belongs_to :tag, index: true

      t.timestamps null: false
    end
  end
end
