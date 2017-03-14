# frozen_string_literal: true
class AddAvatarToUser < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar
  end
end
