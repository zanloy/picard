class CreateLogItems < ActiveRecord::Migration
  def change
    create_table :log_items do |t|
      t.belongs_to :entered_by, class_name: :user, index: true
      t.belongs_to :poc, class_name: :user, index: true
      t.datetime :when
      t.belongs_to :environment, index: true
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
  end
end
