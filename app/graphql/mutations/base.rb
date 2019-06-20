# frozen_string_literal: true

class Mutations::Base < GraphQL::Schema::RelayClassicMutation
  object_class Types::BaseObject
  input_object_class Types::BaseInputObject

  def current_ability
    context[:current_ability]
  end

  def current_user
    context[:current_user]
  end
end
