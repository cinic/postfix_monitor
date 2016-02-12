# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160212004412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "log_records", force: :cascade do |t|
    t.string   "postfix_id"
    t.string   "client"
    t.inet     "client_ip"
    t.string   "message_id"
    t.string   "status"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "delivered"
    t.integer  "status_code", limit: 2
  end

  add_index "log_records", ["client"], name: "index_log_records_on_client", using: :btree
  add_index "log_records", ["delivered"], name: "index_log_records_on_delivered", using: :btree
  add_index "log_records", ["postfix_id"], name: "index_log_records_on_postfix_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "postfix_queue_id"
    t.string   "postfix_message_id"
    t.string   "subject"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "client"
  end

  add_index "messages", ["postfix_queue_id"], name: "index_messages_on_postfix_queue_id", unique: true, using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string   "address"
    t.string   "status"
    t.string   "status_raw"
    t.boolean  "delivered"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "recipients", ["delivered"], name: "index_recipients_on_delivered", using: :btree
  add_index "recipients", ["message_id"], name: "index_recipients_on_message_id", using: :btree

  add_foreign_key "recipients", "messages"
end
