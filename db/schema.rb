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

ActiveRecord::Schema.define(version: 20171217162529) do

  create_table "authors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "gender"
    t.string "address"
    t.string "dob"
    t.string "description"
    t.integer "publisher_id"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_id"], name: "index_authors_on_publisher_id"
  end

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "publisher_year"
    t.integer "amount"
    t.string "name"
    t.string "weight"
    t.string "language"
    t.string "description"
    t.integer "rating", default: 0
    t.integer "publisher_id"
    t.string "cover_image"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
  end

  create_table "borrow_books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "date_borrow"
    t.date "date_return"
    t.integer "status", default: 0, null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrow_books_on_book_id"
    t.index ["user_id", "book_id"], name: "index_borrow_books_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_borrow_books_on_user_id"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "book_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_comments_on_book_id"
    t.index ["user_id", "book_id"], name: "index_comments_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "publishers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "ownerable_id"
    t.string "ownerable_type"
    t.integer "targetable_id"
    t.string "targetable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ownerable_id", "targetable_id"], name: "index_relationships_on_ownerable_id_and_targetable_id"
  end

  create_table "user_ratings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "book_id"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_user_ratings_on_book_id"
    t.index ["user_id", "book_id"], name: "index_user_ratings_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_user_ratings_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email"
    t.string "address"
    t.string "name"
    t.string "phone_number"
    t.string "gender"
    t.string "avatar"
    t.string "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "borrow_books", "books"
  add_foreign_key "borrow_books", "users"
  add_foreign_key "comments", "books"
  add_foreign_key "comments", "users"
  add_foreign_key "user_ratings", "books"
  add_foreign_key "user_ratings", "users"
end
