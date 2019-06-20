# frozen_string_literal: true

# This migration comes from lia (originally 9)
class CreateLiaDocumentLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_document_links do |t|
      t.references :linking_document, null: false, index: true
      t.references :linked_document, null: false, index: true

      t.timestamps null: false
    end
  end
end
