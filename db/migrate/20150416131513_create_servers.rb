class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name, null: false
      t.belongs_to :environment, index: true
      t.string :ip_address
      t.string :ports

      t.timestamps
    end
  end
end
