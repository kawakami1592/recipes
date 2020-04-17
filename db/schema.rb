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

ActiveRecord::Schema.define(version: 2020_04_17_142607) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "ingredients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "recipe_id"
    t.string "ingredient"
    t.string "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "makeds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "recipe_id"
    t.text "text"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_makeds_on_recipe_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "recipe_id"
    t.string "product"
    t.string "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_products_on_recipe_id"
  end

  create_table "recipes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.bigint "category_id"
    t.text "text"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_recipes_on_category_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname"
    t.string "lastname"
    t.string "firstname"
    t.string "lastname_kana"
    t.string "firstname_kana"
    t.string "zipcode"
    t.bigint "Prefecture_id"
    t.string "city"
    t.string "address"
    t.string "buildingname"
    t.string "phone"
    t.bigint "birthyear_id"
    t.bigint "birthmonth_id"
    t.bigint "birthday_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Prefecture_id"], name: "index_users_on_Prefecture_id"
    t.index ["birthday_id"], name: "index_users_on_birthday_id"
    t.index ["birthmonth_id"], name: "index_users_on_birthmonth_id"
    t.index ["birthyear_id"], name: "index_users_on_birthyear_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
