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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110517165005) do

  create_table "associations", :force => true do |t|
    t.integer  "subgroup_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "associations", ["product_id"], :name => "index_associations_on_product_id"
  add_index "associations", ["subgroup_id", "product_id"], :name => "index_associations_on_subgroup_id_and_product_id", :unique => true
  add_index "associations", ["subgroup_id"], :name => "index_associations_on_subgroup_id"

  create_table "categories", :force => true do |t|
    t.string   "categoryname"
    t.integer  "maingroup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["maingroup_id"], :name => "index_categories_on_maingroup_id"

  create_table "cities", :force => true do |t|
    t.string   "cityname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deal_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deal_likes", ["deal_id"], :name => "index_deal_likes_on_deal_id"
  add_index "deal_likes", ["user_id", "deal_id"], :name => "index_deal_likes_on_user_id_and_deal_id", :unique => true
  add_index "deal_likes", ["user_id"], :name => "index_deal_likes_on_user_id"

  create_table "dealcomments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deal_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dealcomments", ["deal_id"], :name => "index_dealcomments_on_deal_id"
  add_index "dealcomments", ["user_id"], :name => "index_dealcomments_on_user_id"

  create_table "deals", :force => true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "originalprice"
    t.integer  "discount"
    t.integer  "maxattenders"
    t.text     "info1"
    t.text     "terms"
    t.text     "aboutdeal"
    t.text     "info2"
    t.text     "address"
    t.datetime "startat"
    t.datetime "endat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  add_index "deals", ["city_id"], :name => "index_deals_on_city_id"

  create_table "maingroups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "variety",    :default => 1
  end

  create_table "product_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_likes", ["product_id"], :name => "index_product_likes_on_product_id"
  add_index "product_likes", ["user_id", "product_id"], :name => "index_product_likes_on_user_id_and_product_id", :unique => true
  add_index "product_likes", ["user_id"], :name => "index_product_likes_on_user_id"

  create_table "productcomments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "productcomments", ["product_id"], :name => "index_productcomments_on_product_id"
  add_index "productcomments", ["user_id"], :name => "index_productcomments_on_user_id"

  create_table "products", :force => true do |t|
    t.string   "productname"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "subgroups", :force => true do |t|
    t.string   "subgroupname"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subgroups", ["category_id"], :name => "index_subgroups_on_category_id"

  create_table "users", :force => true do |t|
    t.string   "login",                                 :null => false
    t.string   "email",                                 :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.integer  "login_count",        :default => 0,     :null => false
    t.integer  "failed_login_count", :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.boolean  "admin",              :default => false
    t.string   "sex"
    t.string   "profession"
    t.date     "birthday"
    t.text     "aboutme"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

end
