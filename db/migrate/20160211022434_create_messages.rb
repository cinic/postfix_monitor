class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :postfix_queue_id
      t.string :postfix_message_id
      t.string :subject

      t.timestamps null: false
    end
    add_index :messages, :postfix_queue_id, unique: true
  end
end
