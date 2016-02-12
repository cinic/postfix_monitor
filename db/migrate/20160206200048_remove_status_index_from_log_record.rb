class RemoveStatusIndexFromLogRecord < ActiveRecord::Migration
  def change
    remove_index :log_records, :status
  end
end
