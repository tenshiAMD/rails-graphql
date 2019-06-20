# frozen_string_literal: true

# This migration comes from lia (originally 11)
class CreateLiaSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_subjects do |t|
      t.string    :name, null: false, index: true
      t.string    :ancestry, index: true
      t.integer   :position, null: false, default: 1

      t.timestamps null: false
    end
    add_index :lia_subjects, %i[name ancestry], name: 'index_lia_subject_tree', unique: true
  end
end
