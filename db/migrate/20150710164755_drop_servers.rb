# frozen_string_literal: true
class DropServers < ActiveRecord::Migration[5.0]
  def change
    drop_table :affections if ActiveRecord::Base.connection.table_exists? :affections
    drop_table :servers if ActiveRecord::Base.connection.table_exists? :servers
  end
end
