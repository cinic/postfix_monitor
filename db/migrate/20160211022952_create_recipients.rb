class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :address
      t.string :status
      t.string :status_raw
      t.boolean :delivered
      t.references :message, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :recipients, :delivered
  end
end
