# frozen_string_literal: true

# This migration comes from lia (originally 7)
class CreateLiaUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_user_profiles do |t|
      t.references  :user, null: false, index: { unique: true }
      t.boolean     :active, null: false, default: true, index: true
      t.string      :first_name, null: false, default: '', limit: 50
      t.string      :middle_name, limit: 50
      t.string      :last_name, limit: 50
      t.string      :suffix_name, limit: 50
      t.boolean     :eula_agreed, default: false, null: false

      t.timestamps null: false
    end
  end
end
