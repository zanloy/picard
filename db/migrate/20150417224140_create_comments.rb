class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true, nil: false
      t.belongs_to :user, index: true, nil: false
      t.string :comment, null: false

      t.timestamps
    end
  end
end
