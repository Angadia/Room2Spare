# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_02_030018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.time "start_time"
    t.time "end_time"
    t.integer "one_hour_rental_price"
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_availabilities_on_room_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "status"
    t.bigint "room_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_bookings_on_course_id"
    t.index ["room_id"], name: "index_bookings_on_room_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "status"
    t.integer "tuition"
    t.integer "capacity"
    t.string "image_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_courses_on_title", unique: true
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.string "status"
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "contact_number"
    t.boolean "parking"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_facilities_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.string "area"
    t.string "image_url"
    t.boolean "whiteboard"
    t.boolean "internet"
    t.bigint "facility_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["facility_id"], name: "index_rooms_on_facility_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.integer "duration"
    t.bigint "booking_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_time_slots_on_booking_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "contact_number"
    t.boolean "is_admin", default: false
    t.boolean "is_manager", default: false
    t.boolean "is_teacher", default: false
    t.boolean "is_student", default: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "availabilities", "rooms"
  add_foreign_key "bookings", "courses"
  add_foreign_key "bookings", "rooms"
  add_foreign_key "courses", "users"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "facilities", "users"
  add_foreign_key "rooms", "facilities"
  add_foreign_key "time_slots", "bookings"
end
