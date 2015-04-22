class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.boolean :on_new_change, default: false, null: false, index: true
      t.boolean :on_new_event, default: false, null: false, index: true

      t.timestamps null: false
    end
  end
end