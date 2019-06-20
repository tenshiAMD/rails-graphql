# frozen_string_literal: true

# This migration comes from lia (originally 3)
class CreateLiaDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_documents do |t|
      t.references  :court_division
      t.text        :issuance_no, null: false, default: '', index: true
      t.text        :title, null: false, default: ''
      t.text        :signatory, null: false, default: ''
      t.date        :doc_date, index: true
      t.integer     :doc_year, null: false, default: 0, index: true
      t.boolean     :publish, null: false, default: false, index: true
      t.text        :committee, null: false, default: ''
      t.text        :councilor, null: false, default: ''
      t.text        :author, null: false, default: ''
      t.text        :members_of_division, null: false, default: ''
      t.text        :ponente, null: false, default: ''
      t.text        :subject, null: false, default: ''
      t.text        :parties, null: false, default: ''
      t.text        :case_status, null: false, default: ''
      t.text        :content, null: false, default: ''

      t.timestamps null: false
    end

    add_index :lia_documents, %i[doc_date doc_year], name: 'index_lia_date_and_year'
    add_index :lia_documents, %i[doc_date publish], name: 'index_lia_date_publish'
    add_index :lia_documents, %i[doc_year publish], name: 'index_lia_year_publish'
    add_index :lia_documents, %i[doc_date doc_year publish], name: 'index_lia_date_and_year_publish'
  end
end
