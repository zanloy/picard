# frozen_string_literal: true
class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :apikey
      t.string :address
      t.string :company
      t.string :phone
      t.string :alternative_contact
      t.string :im_address
      t.string :va_email

      t.timestamps null: false
    end
  end
end
