class AddShortnameToEnvironment < ActiveRecord::Migration
  def change
    add_column :environments, :shortname, :string
  end
end
