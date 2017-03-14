# frozen_string_literal: true
class AddPocToCerticates < ActiveRecord::Migration[5.0]
  def change
    add_column :certificates, :poc, :string
  end
end
