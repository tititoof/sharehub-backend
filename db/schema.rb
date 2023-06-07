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

ActiveRecord::Schema[7.0].define(version: 2023_06_07_055941) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "code_qualities_managements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "project_name"
    t.uuid "project_id", null: false
    t.string "qualitable_type", null: false
    t.uuid "qualitable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "project_name"], name: "cq_managements_index_on_project_id_and_project_name", unique: true
    t.index ["project_id"], name: "index_code_qualities_managements_on_project_id"
    t.index ["qualitable_type", "qualitable_id"], name: "index_code_qualities_managements_on_qualitable"
  end

  create_table "code_qualities_sonarqubes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "access_token"
    t.string "api_url"
    t.string "name"
    t.uuid "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "sonarqubes_index_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_code_qualities_sonarqubes_on_organization_id"
  end

  create_table "communications_conversations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "communications_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "conversation_id", null: false
    t.uuid "user_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_communications_messages_on_conversation_id"
    t.index ["user_id"], name: "index_communications_messages_on_user_id"
  end

  create_table "communications_participants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "member_type", null: false
    t.uuid "member_id", null: false
    t.uuid "conversation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_communications_participants_on_conversation_id"
    t.index ["member_type", "member_id"], name: "index_communications_participants_on_member"
  end

  create_table "galleries_albums", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "albumable_type", null: false
    t.uuid "albumable_id", null: false
    t.string "title"
    t.text "description"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["albumable_type", "albumable_id"], name: "index_galleries_albums_on_albumable"
  end

  create_table "galleries_media", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.uuid "album_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_galleries_media_on_album_id"
  end

  create_table "location_cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "latitude"
    t.string "longitude"
    t.uuid "country_id", null: false
    t.uuid "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_location_cities_on_country_id"
    t.index ["state_id"], name: "index_location_cities_on_state_id"
  end

  create_table "location_countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "emoji"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_location_countries_on_code", unique: true
  end

  create_table "location_states", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.uuid "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_location_states_on_country_id"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.date "borned_at"
    t.string "address"
    t.string "phone_number"
    t.string "email_address"
    t.string "website"
    t.text "activity_description"
    t.string "activity_sector"
    t.float "annual_turnover"
    t.integer "number_of_employees"
    t.string "legal_status"
    t.string "registration_number"
    t.string "region"
    t.uuid "country_id", null: false
    t.uuid "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "admin_id", null: false
    t.index ["admin_id"], name: "index_organizations_on_admin_id"
    t.index ["city_id"], name: "index_organizations_on_city_id"
    t.index ["country_id"], name: "index_organizations_on_country_id"
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "project_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "member_id", null: false
    t.uuid "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_project_members_on_member_id"
    t.index ["project_id"], name: "index_project_members_on_project_id"
  end

  create_table "project_platforms_managements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "project_name"
    t.uuid "project_id", null: false
    t.string "platformable_type", null: false
    t.uuid "platformable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platformable_type", "platformable_id"], name: "index_project_platforms_managements_on_platformable"
    t.index ["project_id", "project_name"], name: "managements_index_on_project_id_and_project_name", unique: true
    t.index ["project_id"], name: "index_project_platforms_managements_on_project_id"
  end

  create_table "project_platforms_openprojects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "api_url"
    t.uuid "organization_id", null: false
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "openprojects_index_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_project_platforms_openprojects_on_organization_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "start_at"
    t.date "end_at"
    t.string "status"
    t.uuid "manager_id", null: false
    t.string "external_references"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "organization_id", null: false
    t.index ["manager_id"], name: "index_projects_on_manager_id"
    t.index ["organization_id", "title"], name: "index_projects_on_organization_id_and_title", unique: true
    t.index ["organization_id"], name: "index_projects_on_organization_id"
  end

  create_table "source_controls_giteas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "api_url"
    t.string "access_token"
    t.string "ip_address"
    t.integer "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.uuid "organization_id", null: false
    t.index ["organization_id", "name"], name: "index_source_controls_giteas_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_source_controls_giteas_on_organization_id"
  end

  create_table "source_controls_repositories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "owner"
    t.string "repo"
    t.uuid "project_id", null: false
    t.string "sourcable_type", null: false
    t.uuid "sourcable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "name"], name: "index_source_controls_repositories_on_project_id_and_name", unique: true
    t.index ["project_id"], name: "index_source_controls_repositories_on_project_id"
    t.index ["sourcable_type", "sourcable_id"], name: "index_source_controls_repositories_on_sourcable"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.boolean "is_admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "users_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "kind"
    t.uuid "admin_id", null: false
    t.uuid "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_users_groups_on_admin_id"
    t.index ["name"], name: "index_users_groups_on_name", unique: true
    t.index ["organization_id"], name: "index_users_groups_on_organization_id"
  end

  create_table "users_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "member_type", null: false
    t.uuid "member_id", null: false
    t.string "joinable_type", null: false
    t.uuid "joinable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["joinable_type", "joinable_id"], name: "index_users_memberships_on_joinable"
    t.index ["member_type", "member_id"], name: "index_users_memberships_on_member"
  end

  create_table "users_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.date "date_of_birth"
    t.string "nickname"
    t.uuid "city_id"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_users_profiles_on_city_id"
    t.index ["nickname"], name: "index_users_profiles_on_nickname", unique: true
    t.index ["user_id"], name: "index_users_profiles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "code_qualities_managements", "projects"
  add_foreign_key "code_qualities_sonarqubes", "organizations"
  add_foreign_key "communications_messages", "communications_conversations", column: "conversation_id"
  add_foreign_key "communications_messages", "users"
  add_foreign_key "communications_participants", "communications_conversations", column: "conversation_id"
  add_foreign_key "galleries_media", "galleries_albums", column: "album_id"
  add_foreign_key "location_cities", "location_countries", column: "country_id"
  add_foreign_key "location_cities", "location_states", column: "state_id"
  add_foreign_key "location_states", "location_countries", column: "country_id"
  add_foreign_key "organizations", "location_cities", column: "city_id"
  add_foreign_key "organizations", "location_countries", column: "country_id"
  add_foreign_key "organizations", "users", column: "admin_id"
  add_foreign_key "project_members", "projects"
  add_foreign_key "project_members", "users", column: "member_id"
  add_foreign_key "project_platforms_managements", "projects"
  add_foreign_key "project_platforms_openprojects", "organizations"
  add_foreign_key "projects", "organizations"
  add_foreign_key "projects", "users", column: "manager_id"
  add_foreign_key "source_controls_giteas", "organizations"
  add_foreign_key "source_controls_repositories", "projects"
  add_foreign_key "users_groups", "organizations"
  add_foreign_key "users_groups", "users", column: "admin_id"
  add_foreign_key "users_profiles", "location_cities", column: "city_id"
  add_foreign_key "users_profiles", "users"
end
