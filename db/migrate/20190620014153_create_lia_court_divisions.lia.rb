# frozen_string_literal: true

# This migration comes from lia (originally 14)
class CreateLiaCourtDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_court_divisions do |t|
      t.string    :name, null: false, default: '', index: true
      t.string    :short_name, null: false, default: '', index: true
      t.integer   :position, null: false, default: 1

      t.timestamps
    end

    add_index :lia_court_divisions, %i[short_name name], unique: true
  end
end
