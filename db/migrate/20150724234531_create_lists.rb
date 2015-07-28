class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :description
      t.text :schema
      t.integer :list_items_count
      t.belongs_to :last_added_by, class_name: :user
      t.date :last_added_on

      t.timestamps null: false
    end
  end
end
