class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :hashed_password
      t.string :name, default: ''
      t.boolean :enabled, default: false
      t.boolean :admin, default: false
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
