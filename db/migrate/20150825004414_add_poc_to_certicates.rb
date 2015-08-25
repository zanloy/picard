class AddPocToCerticates < ActiveRecord::Migration
  def change
    add_column :certificates, :poc, :string
  end
end
