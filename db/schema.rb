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

ActiveRecord::Schema[7.1].define(version: 2023_10_25_023435) do
  create_table "action_text_rich_texts", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authors", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", default: ""
    t.string "display_name", default: ""
    t.string "uuid"
    t.integer "author_id"
    t.integer "category_id"
    t.string "tag", default: ""
    t.string "desc", default: "..."
    t.string "path"
    t.string "remark"
    t.text "pre_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.text "content"
    t.integer "created_by"
    t.string "created_by_name"
    t.integer "updated_by"
    t.string "updated_by_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "fates", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phone_infos", charset: "utf8mb4", force: :cascade do |t|
    t.string "mobile_number"
    t.string "mobile_area"
    t.string "mobile_type"
    t.string "area_code"
    t.string "province_name"
    t.string "province_code"
    t.string "city_name"
    t.string "city_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mobile_number"], name: "index_phone_infos_on_mobile_number"
  end

  create_table "posts", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "created_by"
    t.string "created_by_name"
    t.integer "updated_by"
    t.string "updated_by_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "yys_atlas", charset: "utf8mb4", force: :cascade do |t|
    t.string "nick_name"
    t.text "sids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_mitamas", charset: "utf8mb4", force: :cascade do |t|
    t.string "mid"
    t.string "name"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_patches", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_regions", charset: "utf8mb4", force: :cascade do |t|
    t.string "key"
    t.string "name"
    t.string "mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_shi_shens", charset: "utf8mb4", force: :cascade do |t|
    t.string "sid"
    t.string "name"
    t.string "name_sp", comment: "sp皮肤name"
    t.string "kind", default: "SSR", comment: "SSR或SP"
    t.string "form", default: "ORIGIN", comment: "原生（ORIGIN）/联动（LINKAGE），联动式神不参与抽卡游戏"
    t.boolean "cartoon", default: false, comment: "是否有召唤动画"
    t.boolean "cartoon_sp", default: false, comment: "是否有sp召唤动画"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_skills", charset: "utf8mb4", force: :cascade do |t|
    t.string "sid"
    t.string "skill_id"
    t.string "skill_name"
    t.string "skill_mode"
    t.string "skill_kind"
    t.string "skill_damage"
    t.boolean "extra"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_summon_modes", charset: "utf8mb4", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_summons", charset: "utf8mb4", force: :cascade do |t|
    t.string "mode_id"
    t.string "sid"
    t.integer "up_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yys_users", charset: "utf8mb4", force: :cascade do |t|
    t.string "ip"
    t.string "name"
    t.integer "seq", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "posts"
end
