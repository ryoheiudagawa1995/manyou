ActiveRecord::Schema.define(version: 2020_05_14_053008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labellings", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_labellings_on_label_id"
    t.index ["task_id"], name: "index_labellings_on_task_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "task_id"
    t.index ["task_id"], name: "index_labels_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.date "limit", default: "2020-12-31"
    t.string "status", default: "未着手"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["status"], name: "index_tasks_on_status"
    t.index ["title"], name: "index_tasks_on_title"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "labellings", "labels"
  add_foreign_key "labellings", "tasks"
  add_foreign_key "labels", "tasks"
  add_foreign_key "tasks", "users"
end
