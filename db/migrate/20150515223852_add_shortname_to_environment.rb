# frozen_string_literal: true
class AddShortnameToEnvironment < ActiveRecord::Migration[5.0]
  def change
    add_column :environments, :shortname, :string
  end
end
