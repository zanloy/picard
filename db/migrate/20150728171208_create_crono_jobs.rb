# frozen_string_literal: true
class CreateCronoJobs < ActiveRecord::Migration[5.0]
  def self.up
    create_table :crono_jobs do |t|
      t.string    :job_id, null: false
      t.text      :log
      t.datetime  :last_performed_at
      t.boolean   :healthy
      t.timestamps null: false
    end
    add_index :crono_jobs, [:job_id], unique: true
  end

  def self.down
    drop_table :crono_jobs
  end
end
