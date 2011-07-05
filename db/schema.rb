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

ActiveRecord::Schema.define(:version => 20110703051104) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"
  add_index "activities", ["item_id"], :name => "index_activities_on_item_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "associations", :force => true do |t|
    t.integer  "subgroup_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "associations", ["product_id"], :name => "index_associations_on_product_id"
  add_index "associations", ["subgroup_id", "product_id"], :name => "index_associations_on_subgroup_id_and_product_id", :unique => true
  add_index "associations", ["subgroup_id"], :name => "index_associations_on_subgroup_id"

  create_table "beverage_edits", :force => true do |t|
    t.integer  "edit_id"
    t.string   "alcohol_content"
    t.string   "funfact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beverage_edits", ["edit_id"], :name => "index_beverage_edits_on_edit_id", :unique => true

  create_table "beverages", :force => true do |t|
    t.integer  "p_id"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beverages", ["p_id"], :name => "index_beverages_on_p_id", :unique => true

  create_table "book_edits", :force => true do |t|
    t.integer  "edit_id"
    t.string   "about_author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_edits", ["edit_id"], :name => "index_book_edits_on_edit_id", :unique => true

  create_table "books", :force => true do |t|
    t.integer  "p_id"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["p_id"], :name => "index_books_on_p_id", :unique => true

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

  create_table "comments", :force => true do |t|
    t.integer  "u_id"
    t.integer  "p_id"
    t.string   "reply"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compgame_edits", :force => true do |t|
    t.integer  "edit_id"
    t.integer  "stages"
    t.string   "cheetsheet"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "compgame_edits", ["edit_id"], :name => "index_compgame_edits_on_edit_id", :unique => true

  create_table "compgames", :force => true do |t|
    t.integer  "p_id"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "compgames", ["p_id"], :name => "index_compgames_on_p_id", :unique => true

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
    t.integer  "merchant_id"
  end

  add_index "deals", ["city_id"], :name => "index_deals_on_city_id"

  create_table "edit_likes", :force => true do |t|
    t.integer  "edit_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editinfos", :force => true do |t|
    t.integer  "p_id"
    t.integer  "u_id"
    t.integer  "category"
    t.string   "desc"
    t.string   "review"
    t.string   "ytube_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "like"
  end

  add_index "editinfos", ["p_id", "u_id"], :name => "index_editinfos_on_p_id_and_u_id", :unique => true

  create_table "followers", :force => true do |t|
    t.integer  "followed"
    t.integer  "following"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "perm"
  end

  add_index "followers", ["followed", "following"], :name => "index_followers_on_followed_and_following", :unique => true

  create_table "likes_tables", :force => true do |t|
    t.integer  "u_id"
    t.integer  "p_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes_tables", ["u_id", "p_id"], :name => "index_likes_tables_on_u_id_and_p_id", :unique => true

  create_table "maingroups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "variety",    :default => 1
  end

  create_table "merchant_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchant_likes", ["merchant_id"], :name => "index_merchant_likes_on_merchant_id"
  add_index "merchant_likes", ["user_id", "merchant_id"], :name => "index_merchant_likes_on_user_id_and_merchant_id", :unique => true
  add_index "merchant_likes", ["user_id"], :name => "index_merchant_likes_on_user_id"

  create_table "merchantcomments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "merchant_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchantcomments", ["merchant_id"], :name => "index_merchantcomments_on_merchant_id"
  add_index "merchantcomments", ["user_id"], :name => "index_merchantcomments_on_user_id"

  create_table "merchants", :force => true do |t|
    t.string   "merchantname"
    t.text     "tribecomment"
    t.text     "merchantinfo"
    t.text     "meraddress"
    t.text     "merchantphone"
    t.string   "merspectext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "deal1_file_name"
    t.string   "deal1_content_type"
    t.integer  "deal1_file_size"
    t.string   "deal2_file_name"
    t.string   "deal2_content_type"
    t.integer  "deal2_file_size"
    t.string   "speciality1_file_name"
    t.string   "speciality1_content_type"
    t.integer  "speciality1_file_size"
    t.string   "speciality2_file_name"
    t.string   "speciality2_content_type"
    t.integer  "speciality2_file_size"
  end

  create_table "mobile_edits", :force => true do |t|
    t.integer  "edit_id"
    t.string   "tech_sup"
    t.string   "fav_apps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mobile_edits", ["edit_id"], :name => "index_mobile_edits_on_edit_id", :unique => true

  create_table "mobiles", :force => true do |t|
    t.integer  "p_id"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mobiles", ["p_id"], :name => "index_mobiles_on_p_id", :unique => true

  create_table "music_edits", :force => true do |t|
    t.integer  "edit_id"
    t.string   "awards"
    t.string   "lyrics"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_edits", ["edit_id"], :name => "index_music_edits_on_edit_id", :unique => true

  create_table "musics", :force => true do |t|
    t.integer  "p_id"
    t.string   "album"
    t.string   "artist"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "musics", ["p_id"], :name => "index_musics_on_p_id", :unique => true

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
    t.string   "tags"
    t.integer  "category"
    t.integer  "rating_id"
  end

  create_table "ratingcategories", :force => true do |t|
    t.integer  "maingroup_id"
    t.string   "ratingname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratingcategories", ["maingroup_id"], :name => "index_ratingcategories_on_maingroup_id"

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "ratingcategory_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["product_id"], :name => "index_ratings_on_product_id"
  add_index "ratings", ["ratingcategory_id"], :name => "index_ratings_on_ratingcategory_id"
  add_index "ratings", ["user_id", "product_id", "ratingcategory_id"], :name => "index_ratings_on_user_id_and_product_id_and_ratingcategory_id", :unique => true
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "ratingtables", :force => true do |t|
    t.integer  "p_id"
    t.string   "category"
    t.integer  "netcount"
    t.integer  "usercount"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "replytocomments", :force => true do |t|
    t.integer  "u_id"
    t.integer  "p_id"
    t.integer  "c_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["product_id"], :name => "index_reviews_on_product_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "subgroups", :force => true do |t|
    t.string   "subgroupname"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subgroups", ["category_id"], :name => "index_subgroups_on_category_id"

  create_table "temp_followers", :force => true do |t|
    t.integer  "followed"
    t.integer  "following"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tempfollowers", :force => true do |t|
    t.integer  "followed"
    t.integer  "following"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                   :null => false
    t.string   "email",                                   :null => false
    t.string   "encrypted_password",                      :null => false
    t.string   "password_salt",                           :null => false
    t.integer  "sign_in_count",        :default => 0,     :null => false
    t.integer  "failed_attempts",      :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.boolean  "admin",                :default => false
    t.string   "sex"
    t.string   "profession"
    t.date     "birthday"
    t.text     "aboutme"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.string   "authentication_token"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
