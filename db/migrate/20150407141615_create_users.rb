class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :hashed_password
      t.string :name
      t.boolean :enabled
      t.boolean :admin
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
