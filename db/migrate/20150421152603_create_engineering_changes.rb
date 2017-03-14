# frozen_string_literal: true
class CreateEngineeringChanges < ActiveRecord::Migration[5.0]
  def change
    create_table :engineering_changes do |t|
      t.belongs_to :entered_by, class_name: :user, index: true
      t.belongs_to :poc, class_name: :user, index: true
      t.datetime :when
      t.belongs_to :environment, index: true, foreign_key: true
      t.string :title, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
