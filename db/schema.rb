ActiveRecord::Schema.define(version: 20161229182418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "user_id"
    t.string   "unique_event_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_uploads_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "email_address"
  end

  add_foreign_key "events", "users"
  add_foreign_key "uploads", "users"
end
