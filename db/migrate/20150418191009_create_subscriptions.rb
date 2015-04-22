class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :subscribable, polymorphic: true, index: true, null: false
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end
  end
end