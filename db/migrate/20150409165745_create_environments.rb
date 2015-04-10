class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
