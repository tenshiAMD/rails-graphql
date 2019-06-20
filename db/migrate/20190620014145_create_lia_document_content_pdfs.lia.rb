# frozen_string_literal: true

# This migration comes from lia (originally 6)
class CreateLiaDocumentContentPdfs < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_document_content_pdfs do |t|
      t.references :document, null: false, index: { unique: true }
      t.attachment :file, null: false
      t.string :file_fingerprint, null: false, index: true

      t.timestamps null: false
    end
    add_index :lia_document_content_pdfs, %i[document_id file_fingerprint],
              unique: true, name: 'index_lia_document_content_pdfs_on_doc_id_and_file_fingerprint'
  end
end
