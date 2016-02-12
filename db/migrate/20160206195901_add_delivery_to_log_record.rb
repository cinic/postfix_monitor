class AddDeliveryToLogRecord < ActiveRecord::Migration
  def change
    add_column :log_records, :delivered, :boolean
    add_index :log_records, :delivered
    add_column :log_records, :status_code, :smallint
  end
end
