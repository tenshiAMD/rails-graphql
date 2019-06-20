# frozen_string_literal: true

# This migration comes from lia (originally 1)
class CreateLiaUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :lia_users do |t|
      t.string :username, index: { unique: true }, null: false
      t.string :email, index: true, null: false

      t.string :encrypted_password,     limit: 128
      t.string :password_salt,          limit: 128

      t.timestamps null: false
    end

    add_index :lia_users, %i[email username], unique: true
  end
end
