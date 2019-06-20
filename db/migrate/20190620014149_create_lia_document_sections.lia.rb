# frozen_string_literal: true

# This migration comes from lia (originally 10)
class CreateLiaDocumentSections < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_document_sections do |t|
      t.references :document, null: false, index: true
      t.references :section, null: false, index: true
      t.integer    :position, null: false, default: 1

      t.timestamps null: false
    end
  end
end
