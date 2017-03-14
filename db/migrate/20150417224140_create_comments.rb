# frozen_string_literal: true
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.text :comment, null: false

      t.timestamps null: false
    end
  end
end
