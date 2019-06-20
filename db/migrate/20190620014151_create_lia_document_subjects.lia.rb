# frozen_string_literal: true

# This migration comes from lia (originally 12)
class CreateLiaDocumentSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_document_subjects do |t|
      t.references :document, null: false, index: true
      t.references :subject, null: false, index: true
      t.integer    :position, null: false, default: 1

      t.timestamps null: false
    end
  end
end
