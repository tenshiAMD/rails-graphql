# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_620_014_154) do
  create_table 'ckeditor_assets', force: :cascade do |t|
    t.string 'data_file_name', null: false
    t.string 'data_content_type'
    t.integer 'data_file_size'
    t.string 'data_fingerprint'
    t.integer 'assetable_id'
    t.string 'assetable_type', limit: 30
    t.string 'type', limit: 30
    t.integer 'width'
    t.integer 'height'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[assetable_type assetable_id], name: 'idx_ckeditor_assetable'
    t.index %w[assetable_type type assetable_id], name: 'idx_ckeditor_assetable_type'
  end

  create_table 'lia_court_divisions', force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'short_name', default: '', null: false
    t.integer 'position', default: 1, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_lia_court_divisions_on_name'
    t.index %w[short_name name], name: 'index_lia_court_divisions_on_short_name_and_name', unique: true
    t.index ['short_name'], name: 'index_lia_court_divisions_on_short_name'
  end

  create_table 'lia_document_content_pdfs', force: :cascade do |t|
    t.integer 'document_id', null: false
    t.string 'file_file_name', null: false
    t.string 'file_content_type', null: false
    t.bigint 'file_file_size', null: false
    t.datetime 'file_updated_at', null: false
    t.string 'file_fingerprint', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[document_id file_fingerprint], name: 'index_lia_document_content_pdfs_on_doc_id_and_file_fingerprint', unique: true
    t.index ['document_id'], name: 'index_lia_document_content_pdfs_on_document_id', unique: true
    t.index ['file_fingerprint'], name: 'index_lia_document_content_pdfs_on_file_fingerprint'
  end

  create_table 'lia_document_file_sources', force: :cascade do |t|
    t.integer 'document_id', null: false
    t.string 'file_file_name', null: false
    t.string 'file_content_type', null: false
    t.bigint 'file_file_size', null: false
    t.datetime 'file_updated_at', null: false
    t.string 'file_fingerprint', null: false
    t.boolean 'primary', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[document_id file_fingerprint], name: 'index_lia_document_file_sources_on_doc_id_and_file_fingerprint', unique: true
    t.index ['document_id'], name: 'index_lia_document_file_sources_on_document_id'
    t.index ['file_fingerprint'], name: 'index_lia_document_file_sources_on_file_fingerprint'
  end

  create_table 'lia_document_links', force: :cascade do |t|
    t.integer 'linking_document_id', null: false
    t.integer 'linked_document_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['linked_document_id'], name: 'index_lia_document_links_on_linked_document_id'
    t.index ['linking_document_id'], name: 'index_lia_document_links_on_linking_document_id'
  end

  create_table 'lia_document_sections', force: :cascade do |t|
    t.integer 'document_id', null: false
    t.integer 'section_id', null: false
    t.integer 'position', default: 1, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['document_id'], name: 'index_lia_document_sections_on_document_id'
    t.index ['section_id'], name: 'index_lia_document_sections_on_section_id'
  end

  create_table 'lia_document_shares', force: :cascade do |t|
    t.integer 'document_id', null: false
    t.string 'sender', default: '', null: false
    t.text 'recipients', default: '', null: false
    t.text 'message', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['document_id'], name: 'index_lia_document_shares_on_document_id'
  end

  create_table 'lia_document_subjects', force: :cascade do |t|
    t.integer 'document_id', null: false
    t.integer 'subject_id', null: false
    t.integer 'position', default: 1, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['document_id'], name: 'index_lia_document_subjects_on_document_id'
    t.index ['subject_id'], name: 'index_lia_document_subjects_on_subject_id'
  end

  create_table 'lia_documents', force: :cascade do |t|
    t.integer 'court_division_id'
    t.text 'issuance_no', default: '', null: false
    t.text 'title', default: '', null: false
    t.text 'signatory', default: '', null: false
    t.date 'doc_date'
    t.integer 'doc_year', default: 0, null: false
    t.boolean 'publish', default: false, null: false
    t.text 'committee', default: '', null: false
    t.text 'councilor', default: '', null: false
    t.text 'author', default: '', null: false
    t.text 'members_of_division', default: '', null: false
    t.text 'ponente', default: '', null: false
    t.text 'subject', default: '', null: false
    t.text 'parties', default: '', null: false
    t.text 'case_status', default: '', null: false
    t.text 'content', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['court_division_id'], name: 'index_lia_documents_on_court_division_id'
    t.index %w[doc_date doc_year publish], name: 'index_lia_date_and_year_publish'
    t.index %w[doc_date doc_year], name: 'index_lia_date_and_year'
    t.index %w[doc_date publish], name: 'index_lia_date_publish'
    t.index ['doc_date'], name: 'index_lia_documents_on_doc_date'
    t.index %w[doc_year publish], name: 'index_lia_year_publish'
    t.index ['doc_year'], name: 'index_lia_documents_on_doc_year'
    t.index ['issuance_no'], name: 'index_lia_documents_on_issuance_no'
    t.index ['publish'], name: 'index_lia_documents_on_publish'
  end

  create_table 'lia_role_users', force: :cascade do |t|
    t.integer 'role_id', null: false
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[role_id user_id], name: 'index_lia_role_users_on_role_id_and_user_id', unique: true
    t.index ['role_id'], name: 'index_lia_role_users_on_role_id'
    t.index ['user_id'], name: 'index_lia_role_users_on_user_id'
  end

  create_table 'lia_roles', force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'resource_type'
    t.integer 'resource_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[name resource_type resource_id], name: 'index_lia_roles_on_name_and_resource_type_and_resource_id', unique: true
    t.index ['name'], name: 'index_lia_roles_on_name'
    t.index %w[resource_type resource_id], name: 'index_lia_roles_on_resource_type_and_resource_id'
  end

  create_table 'lia_sections', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'ancestry'
    t.integer 'position', default: 1, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['ancestry'], name: 'index_lia_sections_on_ancestry'
    t.index %w[name ancestry], name: 'index_lia_section_tree', unique: true
    t.index ['name'], name: 'index_lia_sections_on_name'
  end

  create_table 'lia_subjects', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'ancestry'
    t.integer 'position', default: 1, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['ancestry'], name: 'index_lia_subjects_on_ancestry'
    t.index %w[name ancestry], name: 'index_lia_subject_tree', unique: true
    t.index ['name'], name: 'index_lia_subjects_on_name'
  end

  create_table 'lia_user_profiles', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.boolean 'active', default: true, null: false
    t.string 'first_name', limit: 50, default: '', null: false
    t.string 'middle_name', limit: 50
    t.string 'last_name', limit: 50
    t.string 'suffix_name', limit: 50
    t.boolean 'eula_agreed', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['active'], name: 'index_lia_user_profiles_on_active'
    t.index ['user_id'], name: 'index_lia_user_profiles_on_user_id', unique: true
  end

  create_table 'lia_users', force: :cascade do |t|
    t.string 'username', null: false
    t.string 'email', null: false
    t.string 'encrypted_password', limit: 128
    t.string 'password_salt', limit: 128
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[email username], name: 'index_lia_users_on_email_and_username', unique: true
    t.index ['email'], name: 'index_lia_users_on_email'
    t.index ['username'], name: 'index_lia_users_on_username', unique: true
  end

  create_table 'lia_versions', force: :cascade do |t|
    t.string 'item_type', null: false
    t.integer 'item_id', null: false
    t.string 'event', null: false
    t.string 'whodunnit'
    t.text 'object', limit: 1_073_741_823
    t.datetime 'created_at'
    t.index %w[item_type item_id], name: 'index_lia_versions_on_item_type_and_item_id'
  end
end
