class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name, index: true, null: false
      t.string :domain, default: ''

      t.timestamps
    end
  end
end
