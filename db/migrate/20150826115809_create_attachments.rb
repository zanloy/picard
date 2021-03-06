# frozen_string_literal: true
class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.belongs_to :engineering_change, index: true, foreign_key: true
      t.integer :reference, default: 0
      t.attachment :file

      t.timestamps null: false
    end
  end
end
