class AddSlackUsernameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :slack_username, :string
  end
end
