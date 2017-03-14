# frozen_string_literal: true
class AddSlackUsernameToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :slack_username, :string
  end
end
