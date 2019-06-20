# frozen_string_literal: true

# This migration comes from lia (originally 5)
class CreateLiaDocumentFileSources < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_document_file_sources do |t|
      t.references :document, null: false, index: true
      t.attachment :file, null: false
      t.string :file_fingerprint, null: false, index: true
      t.boolean :primary, null: false, default: false

      t.timestamps null: false
    end
    add_index :lia_document_file_sources, %i[document_id file_fingerprint],
              unique: true, name: 'index_lia_document_file_sources_on_doc_id_and_file_fingerprint'
  end
end
