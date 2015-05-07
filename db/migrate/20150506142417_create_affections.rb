class CreateAffections < ActiveRecord::Migration
  def change
    create_table :affections do |t|
      t.references :affectable, polymorphic: true, index: true, null: false
      t.belongs_to :server, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
