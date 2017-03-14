# frozen_string_literal: true
class CreateCertificateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :certificate_locations do |t|
      t.belongs_to :server, index: true, foreign_key: true
      t.belongs_to :certificate, index: true, foreign_key: true
      t.string :location

      t.timestamps null: false
    end
  end
end
