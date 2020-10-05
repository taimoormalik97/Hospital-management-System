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

ActiveRecord::Schema.define(version: 2020_10_05_063547) do

  create_table "appointments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.date "date", null: false
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.bigint "availability_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.string "state"
    t.index ["availability_id"], name: "index_appointments_on_availability_id"
    t.index ["date", "availability_id"], name: "index_appointments_on_date_and_availability_id", unique: true
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["hospital_id"], name: "index_appointments_on_hospital_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["sequence_num", "hospital_id"], name: "index_appointments_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "availabilities", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "week_day", null: false
    t.datetime "start_slot", null: false
    t.datetime "end_slot", null: false
    t.bigint "doctor_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["doctor_id"], name: "index_availabilities_on_doctor_id"
    t.index ["hospital_id"], name: "index_availabilities_on_hospital_id"
    t.index ["sequence_num", "hospital_id"], name: "index_availabilities_on_sequence_num_and_hospital_id", unique: true
    t.index ["week_day"], name: "index_availabilities_on_week_day"
  end

  create_table "bill_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "bill_id", null: false
    t.string "billable_type", null: false
    t.bigint "billable_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["bill_id"], name: "index_bill_details_on_bill_id"
    t.index ["billable_type", "billable_id"], name: "index_bill_details_on_billable_type_and_billable_id"
    t.index ["hospital_id", "bill_id"], name: "index_bill_details_on_hospital_id_and_bill_id"
    t.index ["hospital_id"], name: "index_bill_details_on_hospital_id"
    t.index ["sequence_num", "hospital_id"], name: "index_bill_details_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "bills", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "billable_type", null: false
    t.bigint "patient_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.decimal "price", precision: 10, default: "0"
    t.index ["hospital_id", "patient_id"], name: "index_bills_on_hospital_id_and_patient_id"
    t.index ["hospital_id"], name: "index_bills_on_hospital_id"
    t.index ["patient_id"], name: "index_bills_on_patient_id"
    t.index ["sequence_num", "hospital_id"], name: "index_bills_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "feedbacks", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "feedback_detail", null: false
    t.bigint "doctor_id", null: false
    t.bigint "appointment_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["appointment_id"], name: "index_feedbacks_on_appointment_id"
    t.index ["doctor_id"], name: "index_feedbacks_on_doctor_id"
    t.index ["hospital_id"], name: "index_feedbacks_on_hospital_id"
    t.index ["sequence_num", "hospital_id"], name: "index_feedbacks_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "hospitals", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.bigint "phone_number", null: false
    t.string "sub_domain", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lab_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "hospital_id", null: false
    t.bigint "test_id", null: false
    t.datetime "sample_collection_date", null: false
    t.datetime "report_generation_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["hospital_id", "id"], name: "index_lab_reports_on_hospital_id_and_id"
    t.index ["hospital_id"], name: "index_lab_reports_on_hospital_id"
    t.index ["patient_id"], name: "index_lab_reports_on_patient_id"
    t.index ["sequence_num", "hospital_id"], name: "index_lab_reports_on_sequence_num_and_hospital_id", unique: true
    t.index ["test_id"], name: "index_lab_reports_on_test_id"
  end

  create_table "medicines", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "quantity", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["hospital_id", "id"], name: "index_medicines_on_hospital_id_and_id"
    t.index ["hospital_id"], name: "index_medicines_on_hospital_id"
    t.index ["sequence_num", "hospital_id"], name: "index_medicines_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "prescribed_medicines", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "medicine_id", null: false
    t.string "usage_instruction", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.bigint "prescription_id", null: false
    t.decimal "quantity", precision: 10, null: false
    t.index ["hospital_id"], name: "index_prescribed_medicines_on_hospital_id"
    t.index ["medicine_id"], name: "index_prescribed_medicines_on_medicine_id"
    t.index ["prescription_id"], name: "index_prescribed_medicines_on_prescription_id"
    t.index ["sequence_num", "hospital_id"], name: "index_prescribed_medicines_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "prescriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "notes"
    t.bigint "appointment_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["appointment_id"], name: "index_prescriptions_on_appointment_id"
    t.index ["hospital_id", "sequence_num"], name: "index_prescriptions_on_hospital_id_and_sequence_num", unique: true
    t.index ["hospital_id"], name: "index_prescriptions_on_hospital_id"
  end

  create_table "purchase_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "purchase_order_id", null: false
    t.bigint "medicine_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["hospital_id", "purchase_order_id"], name: "index_purchase_details_on_hospital_id_and_purchase_order_id"
    t.index ["hospital_id"], name: "index_purchase_details_on_hospital_id"
    t.index ["medicine_id"], name: "index_purchase_details_on_medicine_id"
    t.index ["purchase_order_id"], name: "index_purchase_details_on_purchase_order_id"
    t.index ["sequence_num", "hospital_id"], name: "index_purchase_details_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "purchase_orders", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "vendorname", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "state", null: false
    t.bigint "admin_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["admin_id"], name: "index_purchase_orders_on_admin_id"
    t.index ["hospital_id"], name: "index_purchase_orders_on_hospital_id"
    t.index ["sequence_num", "hospital_id"], name: "index_purchase_orders_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "tests", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "details", null: false
    t.decimal "price", precision: 10, scale: 2
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["hospital_id"], name: "index_tests_on_hospital_id"
    t.index ["name"], name: "index_tests_on_name"
    t.index ["sequence_num", "hospital_id"], name: "index_tests_on_sequence_num_and_hospital_id", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.string "gender"
    t.date "dob"
    t.text "family_history"
    t.string "registration_no"
    t.string "speciality"
    t.decimal "consultancy_fee", precision: 10, scale: 2
    t.bigint "hospital_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sequence_num", null: false
    t.string "profile_picture_file_name"
    t.string "profile_picture_content_type"
    t.integer "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["hospital_id", "email"], name: "index_users_on_hospital_id_and_email"
    t.index ["hospital_id"], name: "index_users_on_hospital_id"
    t.index ["id", "type"], name: "index_users_on_id_and_type"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sequence_num", "hospital_id"], name: "index_users_on_sequence_num_and_hospital_id", unique: true
  end

end
