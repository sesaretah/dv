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

ActiveRecord::Schema.define(version: 20201106075020) do

  create_table "access_controls", force: :cascade do |t|
    t.integer  "user_id",                      limit: 4
    t.integer  "role_id",                      limit: 4
    t.integer  "view_unrelated_articles",      limit: 4
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "alter_content_templates",      limit: 4
    t.integer  "alter_section_items",          limit: 4
    t.integer  "alter_publishers",             limit: 4
    t.integer  "alter_locations",              limit: 4
    t.integer  "alter_publish_sources",        limit: 4
    t.integer  "alter_access_groups",          limit: 4
    t.integer  "alter_profile_groups",         limit: 4
    t.integer  "edit_workflow",                limit: 4
  end

  add_index "access_controls", ["user_id"], name: "index_access_controls_on_user_id", using: :btree

  create_table "access_groups", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "access_groups", ["user_id"], name: "index_access_groups_on_user_id", using: :btree

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

  add_index "areaings", ["article_id"], name: "index_areaings_on_article_id", using: :btree

  create_table "article_areas", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "article_areas", ["user_id"], name: "index_article_areas_on_user_id", using: :btree

  create_table "article_events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "article_events", ["user_id"], name: "index_article_events_on_user_id", using: :btree

  create_table "article_formats", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "article_formats", ["user_id"], name: "index_article_formats_on_user_id", using: :btree

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

  add_index "article_relation_types", ["user_id"], name: "index_article_relation_types_on_user_id", using: :btree

  create_table "article_sources", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "article_sources", ["user_id"], name: "index_article_sources_on_user_id", using: :btree

  create_table "article_types", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "article_types", ["user_id"], name: "index_article_types_on_user_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.text     "abstract",            limit: 65535
    t.text     "content",             limit: 65535
    t.string   "url",                 limit: 255
    t.string   "slug",                limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "workflow_state_id",   limit: 4
    t.integer  "content_template_id", limit: 4
    t.text     "document_contents",   limit: 4294967295
    t.text     "content_wo_tags",     limit: 65535
    t.date     "published_at"
    t.integer  "access_group_id",     limit: 4
    t.string   "description",         limit: 255
    t.text     "notes",               limit: 65535
    t.string   "dimensions",          limit: 255
    t.string   "retrieval_number",    limit: 255
    t.text     "publish_details",     limit: 65535
    t.string   "access_for_others",   limit: 255
    t.integer  "position",            limit: 4
    t.integer  "user_id",             limit: 4
  end

  add_index "articles", ["slug"], name: "slug", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "role_id",     limit: 4
    t.integer  "assigner_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "assignments", ["role_id"], name: "index_assignments_on_role_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "content",          limit: 191
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id",          limit: 4
  end

  create_table "content_templates", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "content_templates", ["user_id"], name: "index_content_templates_on_user_id", using: :btree

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

  add_index "contributions", ["article_id"], name: "index_contributions_on_article_id", using: :btree

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

  add_index "datings", ["article_id"], name: "index_datings_on_article_id", using: :btree

  create_table "duties", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "duties", ["user_id"], name: "index_duties_on_user_id", using: :btree

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

  add_index "formatings", ["article_id"], name: "index_formatings_on_article_id", using: :btree

  create_table "home_settings", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "pp",             limit: 4
    t.string   "sort",           limit: 255
    t.integer  "workflow_state", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "workflow",       limit: 4
  end

  create_table "interconnects", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uuid",       limit: 255
    t.string   "token",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "interconnects", ["token"], name: "index_interconnects_on_token", using: :btree
  add_index "interconnects", ["uuid"], name: "index_interconnects_on_uuid", using: :btree

  create_table "involvements", force: :cascade do |t|
    t.integer  "article_id",   limit: 4
    t.integer  "publisher_id", limit: 4
    t.text     "details",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "involvements", ["article_id"], name: "index_involvements_on_article_id", using: :btree

  create_table "keywords", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "keywords", ["user_id"], name: "index_keywords_on_user_id", using: :btree

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
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "article_relation_type_id", limit: 4
    t.integer  "article_id",               limit: 4
    t.integer  "rank",                     limit: 4, default: 0
  end

  add_index "kinships", ["article_id"], name: "index_kinships_on_article_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "languages", ["user_id"], name: "index_languages_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "user_id",     limit: 4
    t.float    "longitude",   limit: 24
    t.float    "latidue",     limit: 24
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "locations", ["user_id"], name: "index_locations_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "sender_id",  limit: 4
    t.integer  "urgency",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "status",     limit: 4
    t.integer  "parent_id",  limit: 4
  end

  create_table "messagings", force: :cascade do |t|
    t.integer  "recipient_id", limit: 4
    t.integer  "message_id",   limit: 4
    t.integer  "status",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "note_templates", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.text     "content",           limit: 65535
    t.string   "notifiable_id",     limit: 255
    t.string   "notifiable_type",   limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "user_id",           limit: 4
    t.string   "notification_type", limit: 255
    t.integer  "emmiter_id",        limit: 4
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "notings", force: :cascade do |t|
    t.integer  "note_template_id", limit: 4
    t.integer  "article_id",       limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
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

  add_index "originatings", ["article_id"], name: "index_originatings_on_article_id", using: :btree

  create_table "profile_groupings", force: :cascade do |t|
    t.integer  "profile_id",       limit: 4
    t.integer  "profile_group_id", limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "profile_groups", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "profile_groups", ["user_id"], name: "index_profile_groups_on_user_id", using: :btree

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
    t.string   "stage_name",          limit: 255
  end

  create_table "publications", force: :cascade do |t|
    t.integer  "article_id",        limit: 4
    t.integer  "publisher_id",      limit: 4
    t.date     "publication_date"
    t.string   "pp",                limit: 255
    t.string   "vol",               limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "location_id",       limit: 4
    t.integer  "publish_source_id", limit: 4
  end

  add_index "publications", ["article_id"], name: "index_publications_on_article_id", using: :btree

  create_table "publish_sources", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "description",  limit: 65535
    t.integer  "publisher_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id",      limit: 4
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "description",       limit: 255
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "organization_type", limit: 4
  end

  add_index "publishers", ["user_id"], name: "index_publishers_on_user_id", using: :btree

  create_table "role_accesses", force: :cascade do |t|
    t.integer  "role_id",         limit: 4
    t.integer  "access_group_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "abr",         limit: 255
    t.integer  "user_id",     limit: 4
    t.boolean  "start_point"
  end

  create_table "section_items", force: :cascade do |t|
    t.integer  "section_id",  limit: 4
    t.string   "item_name",   limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.integer  "user_id",     limit: 4
    t.string   "klass_name",  limit: 255
  end

  add_index "section_items", ["user_id"], name: "index_section_items_on_user_id", using: :btree

  create_table "sectionings", force: :cascade do |t|
    t.integer  "section_id",      limit: 4
    t.integer  "section_item_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "workflow_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title",       limit: 255
  end

  add_index "sections", ["user_id"], name: "index_sections_on_user_id", using: :btree

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

  add_index "speakings", ["article_id"], name: "index_speakings_on_article_id", using: :btree

  create_table "ssos", force: :cascade do |t|
    t.string   "utid",       limit: 255
    t.string   "uuid",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "status",     limit: 255
  end

  add_index "ssos", ["uuid"], name: "index_ssos_on_uuid", using: :btree

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

  add_index "title_types", ["user_id"], name: "index_title_types_on_user_id", using: :btree

  create_table "titlings", force: :cascade do |t|
    t.integer  "title_type_id", limit: 4
    t.integer  "article_id",    limit: 4
    t.integer  "status",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "content",       limit: 255
  end

  add_index "titlings", ["article_id"], name: "index_titlings_on_article_id", using: :btree

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

  add_index "typings", ["article_id"], name: "index_typings_on_article_id", using: :btree

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
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 8
    t.datetime "attachment_updated_at"
    t.string   "attachment_type",         limit: 255
    t.string   "title",                   limit: 255
    t.text     "detail",                  limit: 65535
    t.integer  "user_id",                 limit: 4
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
    t.string   "utid",                   limit: 255
    t.string   "name",                   limit: 255
    t.string   "surename",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "voting_id",  limit: 4
    t.integer  "outcome",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "article_id", limit: 4
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  create_table "votings", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "deadline",     limit: 4
    t.integer  "voting_type",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "word_templates", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.integer  "workflow_id",           limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id",               limit: 4
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 8
    t.datetime "document_updated_at"
  end

  add_index "word_templates", ["user_id"], name: "index_word_templates_on_user_id", using: :btree

  create_table "workflow_role_accesses", force: :cascade do |t|
    t.integer  "workflow_id",              limit: 4
    t.integer  "role_id",                  limit: 4
    t.boolean  "own_article_traceable"
    t.boolean  "other_articles_traceable"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "workflow_role_accesses", ["role_id"], name: "index_workflow_role_accesses_on_role_id", using: :btree
  add_index "workflow_role_accesses", ["workflow_id"], name: "index_workflow_role_accesses_on_workflow_id", using: :btree

  create_table "workflow_states", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "workflow_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "node_id",     limit: 4
    t.text     "editable",    limit: 65535
    t.integer  "refundable",  limit: 4
    t.integer  "commentable", limit: 4
    t.integer  "start_point", limit: 4
    t.integer  "end_point",   limit: 4
    t.integer  "role_id",     limit: 4
    t.integer  "votable",     limit: 4
    t.integer  "publishable", limit: 4
  end

  add_index "workflow_states", ["role_id"], name: "index_workflow_states_on_role_id", using: :btree
  add_index "workflow_states", ["workflow_id"], name: "index_workflow_states_on_workflow_id", using: :btree

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

  add_index "workflow_transitions", ["article_id"], name: "index_workflow_transitions_on_article_id", using: :btree
  add_index "workflow_transitions", ["user_id"], name: "index_workflow_transitions_on_user_id", using: :btree

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

  add_index "workflows", ["user_id"], name: "index_workflows_on_user_id", using: :btree

end
