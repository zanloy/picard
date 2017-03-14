# frozen_string_literal: true
class AddLocationsCountToCertificate < ActiveRecord::Migration[5.0]
  def change
    add_column :certificates, :locations_count, :integer, default: 0
  end
end
