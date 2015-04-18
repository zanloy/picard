class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :subscribable, polymorphic: true, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.boolean :on_new, default: false
      t.boolean :on_change, default: false
      t.boolean :on_comment, default: false

      t.timestamps
    end
  end
end
