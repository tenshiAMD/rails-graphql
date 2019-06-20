# frozen_string_literal: true

# This migration comes from lia (originally 4)
class CreateLiaSections < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_sections do |t|
      t.string    :name, null: false, index: true
      t.string    :ancestry, index: true
      t.integer   :position, null: false, default: 1

      t.timestamps null: false
    end
    add_index :lia_sections, %i[name ancestry], name: 'index_lia_section_tree', unique: true
  end
end
