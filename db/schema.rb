# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20181111081119) do

  create_table "access_controls", force: :cascade do |t|
    t.integer  "user_id",                      limit: 4
    t.integer  "role_id",                      limit: 4
    t.integer  "view_unrelated_articles",      limit: 4, default: 0
    t.integer  "view_article_logs",            limit: 4
    t.integer  "view_workflow_transactions",   limit: 4
    t.integer  "create_workflow",              limit: 4
    t.integer  "alter_article_areas",          limit: 4
    t.integer  "alter_article_events",         limit: 4
    t.integer  "alter_article_formats",        limit: 4
    t.integer  "alter_article_relation_types", limit: 4
    t.integer  "alter_article_sources",        limit: 4
    t.integer  "alter_article_types",          limit: 4
    t.integer  "alter_keywords",               limit: 4
    t.integer  "alter_languages",              limit: 4
    t.integer  "alter_profiles",               limit: 4
    t.integer  "alter_roles",                  limit: 4
    t.integer  "alter_duties",                 limit: 4
    t.integer  "alter_title_types",            limit: 4
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "areaing_histories", force: :cascade do |t|
    t.integer  "article_id",             limit: 4
    t.integer  "article_area_id",        limit: 4
    t.string   "revision_number",        limit: 255
    t.integer  "user_id",                limit: 4
    t.integer  "workflow_transition_id", limit: 4
    t.integer  "areaing_id",             limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "areaings", force: :cascade do |t|
    t.integer  "article_area_id", limit: 4
    t.integer  "article_id",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "article_areas", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "article_events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "article_formats", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "article_histories", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.text     "abstract",               limit: 65535
    t.text     "content",                limit: 65535
    t.string   "url",                    limit: 255
    t.text     "document_contents",      limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "revision_number",        limit: 255
    t.integer  "user_id",                limit: 4
    t.integer  "article_id",             limit: 4
    t.integer  "workflow_transition_id", limit: 4
  end

  create_table "article_relation_types", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "article_sources", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "article_types", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.text     "abstract",          limit: 65535
    t.text     "content",           limit: 65535
    t.string   "url",               limit: 255
    t.string   "slug",              limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "workflow_state_id", limit: 4
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "role_id",     limit: 4
    t.integer  "assigner_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",          limit: 4294967295
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id",          limit: 4
  end

  create_table "contribution_histories", force: :cascade do |t|
    t.integer  "article_id",             limit: 4
    t.integer  "role_id",                limit: 4
    t.integer  "duty_id",                limit: 4
    t.integer  "profile_id",             limit: 4
    t.integer  "revision_number",        limit: 4
    t.integer  "user_id",                limit: 4
    t.integer  "workflow_transition_id", limit: 4
    t.integer  "contribution_id",        limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "contributions", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.integer  "role_id",    limit: 4
    t.integer  "duty_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "profile_id", limit: 4
  end

  create_table "dating_histories", force: :cascade do |t|
    t.integer  "article_id",             limit: 4
    t.integer  "article_event_id",       limit: 4
    t.date     "event_date"
    t.string   "revision_number",        limit: 255
    t.integer  "user_id",                limit: 4
    t.integer  "workflow_transition_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "dating_id",              limit: 4
  end

  create_table "datings", force: :cascade do |t|
    t.integer  "article_event_id", limit: 4
    t.integer  "article_id",       limit: 4
    t.date     "event_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "duties", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "formating_histories", force: :cascade do |t|
    t.integer  "article_format_id",      limit: 4
    t.integer  "article_id",             limit: 4
    t.integer  "user_id",                limit: 4
    t.string   "revision_number",        limit: 255
    t.integer  "workflow_state_id",      limit: 4
    t.integer  "formating_id",           limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "workflow_transition_id", limit: 4
  end

  create_table "formatings", force: :cascade do |t|
    t.integer  "article_format_id", limit: 4
    t.integer  "article_id",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "kinship_histories", force: :cascade do |t|
    t.integer  "user_id",                  limit: 4
    t.integer  "kin_id",                   limit: 4
    t.integer  "article_id",               limit: 4
    t.integer  "article_relation_type_id", limit: 4
    t.string   "revision_number",          limit: 255
    t.integer  "workflow_transition_id",   limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "kinship_id",               limit: 4
  end

  create_table "kinships", force: :cascade do |t|
    t.integer  "user_id",                  limit: 4
    t.integer  "kin_id",                   limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "article_relation_type_id", limit: 4
    t.integer  "article_id",               limit: 4
  end

  create_table "languages", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
    t.string   "notifiable_id",   limit: 255
    t.string   "notifiable_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "originating_histories", force: :cascade do |t|
    t.integer  "article_id",             limit: 4
    t.integer  "article_source_id",      limit: 4
    t.integer  "originating_id",         limit: 4
    t.string   "revision_number",        limit: 255
    t.integer  "user_id",                limit: 4
    t.integer  "workflow_transition_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "originatings", force: :cascade do |t|
    t.integer  "article_id",        limit: 4
    t.integer  "article_source_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "surename",            limit: 255
    t.integer  "user_id",             limit: 4
    t.string   "phone_number",        limit: 255
    t.string   "cellphone_number",    limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 8
    t.datetime "avatar_updated_at"
    t.string   "email",               limit: 255
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "abr",         limit: 255
    t.integer  "user_id",     limit: 4
  end

  create_table "speaking_histories", force: :cascade do |t|
    t.integer  "article_id",             limit: 4
    t.integer  "language_id",            limit: 4
    t.string   "revision_number",        limit: 255
    t.integer  "user_id",                limit: 4
    t.integer  "workflow_transition_id", limit: 4
    t.integer  "speaking_id",            limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "speakings", force: :cascade do |t|
    t.integer  "language_id", limit: 4
    t.integer  "article_id",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "tagging_histories", force: :cascade do |t|
    t.integer  "taggable_id",            limit: 4
    t.string   "taggable_type",          limit: 255
    t.integer  "target_id",              limit: 4
    t.string   "target_type",            limit: 255
    t.integer  "user_id",                limit: 4
    t.string   "revision_number",        limit: 255
    t.integer  "article_id",             limit: 4
    t.integer  "workflow_transition_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "tagging_id",             limit: 4
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "target_id",     limit: 4
    t.string   "target_type",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "title_types", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "titlings", force: :cascade do |t|
    t.integer  "title_type_id", limit: 4
    t.integer  "article_id",    limit: 4
    t.integer  "status",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "content",       limit: 255
  end

  create_table "typing_histories", force: :cascade do |t|
    t.integer  "article_type_id",        limit: 4
    t.integer  "article_id",             limit: 4
    t.integer  "typing_id",              limit: 4
    t.string   "revision_number",        limit: 255
    t.integer  "user_id",                limit: 4
    t.integer  "workflow_transition_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "typings", force: :cascade do |t|
    t.integer  "article_type_id", limit: 4
    t.integer  "article_id",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "upload_histories", force: :cascade do |t|
    t.string   "uploadable_type",         limit: 255
    t.integer  "uploadable_id",           limit: 4
    t.string   "token",                   limit: 255
    t.string   "attachment_type",         limit: 255
    t.string   "revision_number",         limit: 255
    t.integer  "user_id",                 limit: 4
    t.integer  "workflow_transition_id",  limit: 4
    t.integer  "speaking_id",             limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 8
    t.datetime "attachment_updated_at"
    t.integer  "upload_id",               limit: 4
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "uploadable_type",         limit: 255
    t.integer  "uploadable_id",           limit: 4
    t.string   "token",                   limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 8
    t.datetime "attachment_updated_at"
    t.string   "attachment_type",         limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "current_role_id",        limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workflow_states", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "workflow_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "node_id",     limit: 4
    t.text     "editable",    limit: 16777215
    t.integer  "refundable",  limit: 4
    t.integer  "commentable", limit: 4
    t.integer  "start_point", limit: 4
    t.integer  "end_point",   limit: 4
    t.integer  "role_id",     limit: 4
  end

  create_table "workflow_transitions", force: :cascade do |t|
    t.integer  "workflow_id",     limit: 4
    t.integer  "from_state_id",   limit: 4
    t.integer  "to_state_id",     limit: 4
    t.text     "message",         limit: 65535
    t.integer  "user_id",         limit: 4
    t.integer  "role_id",         limit: 4
    t.integer  "transition_type", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "article_id",      limit: 4
    t.string   "revision_number", limit: 255
  end

  create_table "workflows", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "description",   limit: 65535
    t.integer  "user_id",       limit: 4
    t.text     "graph_data",    limit: 65535
    t.text     "nodes",         limit: 65535
    t.text     "edges",         limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "start_node_id", limit: 4
  end

end
