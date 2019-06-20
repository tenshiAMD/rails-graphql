# frozen_string_literal: true

# This migration comes from lia (originally 13)
class CreateLiaDocumentShares < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_document_shares do |t|
      t.references :document, null: false
      t.string     :sender, null: false, default: ''
      t.text       :recipients, null: false, default: ''
      t.text       :message, null: false, default: ''

      t.timestamps null: false
    end
  end
end
