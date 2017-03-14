# frozen_string_literal: true
class AddOnNewUserToProfile < ActiveRecord::Migration
  def change
    add_column :notifications, :on_new_user, :boolean, default: false, null:false
  end
end
