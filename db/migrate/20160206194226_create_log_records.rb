class CreateLogRecords < ActiveRecord::Migration
  def change
    create_table :log_records do |t|
      t.string :postfix_id
      t.string :client
      t.inet :client_ip
      t.string :message_id
      t.string :status

      t.timestamps null: false
    end
    add_index :log_records, :postfix_id
    add_index :log_records, :client
    add_index :log_records, :status
  end
end
