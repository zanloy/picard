# frozen_string_literal: true
class AddBannedToUser < ActiveRecord::Migration
  def change
    add_column :users, :banned, :boolean, default: false
  end
end
