class CreateLogItems < ActiveRecord::Migration
  def change
    create_table :log_items do |t|
      t.belongs_to :user, index: true
      t.datetime :when
      t.belongs_to :environment, index: true
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
