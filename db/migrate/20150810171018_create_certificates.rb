class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string   :subject
      t.string   :cn
      t.string   :issuer
      t.datetime :not_before
      t.datetime :not_after
      t.string   :signature_algorithm
      t.integer  :key_length
      t.string   :modulus
      t.text     :pem, null: false

      t.timestamps null: false
    end
  end
end
