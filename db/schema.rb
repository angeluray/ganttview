# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_05_005927) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diagrams", force: :cascade do |t|
    t.string "task_name"
    t.string "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "progress"
    t.string "duration"
    t.string "priority"
    t.string "parent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "task_name"
    t.string "task_description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "duration"
    t.integer "parent_unique_id"
    t.integer "unique_task_id"
    t.bigint "project_id", null: false
    t.bigint "task_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["task_type_id"], name: "index_tasks_on_task_type_id"
  end

  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "task_types"
end
