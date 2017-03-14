# frozen_string_literal: true
class AddLocationsCountToCertificate < ActiveRecord::Migration
  def change
    add_column :certificates, :locations_count, :integer, default: 0
  end
end
