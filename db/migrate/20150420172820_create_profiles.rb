class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :address
      t.string :company
      t.string :phone
      t.string :alternative_contact
      t.string :im_address
      t.string :va_email

      t.timestamps
    end
  end
end
