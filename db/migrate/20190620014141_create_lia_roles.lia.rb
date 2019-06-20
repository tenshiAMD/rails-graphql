# frozen_string_literal: true

# This migration comes from lia (originally 2)
class CreateLiaRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_roles do |t|
      t.string :name, null: false, default: ''
      t.references :resource, polymorphic: true

      t.timestamps
    end

    create_table :lia_role_users do |t|
      t.references :role, null: false
      t.references :user, null: false

      t.timestamps
    end

    add_index :lia_roles, :name
    add_index :lia_roles, %i[name resource_type resource_id], unique: true
    add_index :lia_role_users, %i[role_id user_id], unique: true
  end
end
