# frozen_string_literal: true

module Types
  class User < Types::LiaBaseObject
    description 'User record'

    global_id_field :id

    field :role_ids, [ID], null: true

    field :email, String, null: false
    field :username, String, null: false
    field :active, Boolean, null: false

    field :name, String, null: false
    field :fullName, String, null: false
    field :firstName, String, null: false
    field :middleName, String, null: true
    field :lastName, String, null: true
    field :suffixName, String, null: true

    field :initials, String, null: false
    def initials
      [object.first_name[0], object.middle_name[0], object.last_name[0]].join('.').upcase
    end
  end
end
