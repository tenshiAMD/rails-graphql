# frozen_string_literal: true

class Mutations::UpdateSection < Mutations::Base
  null true

  argument :id, ID, required: true
  argument :name, String, required: false
  argument :parent_id, ID, required: false
  argument :position, Int, required: false

  field :section, Types::Section, null: true
  field :errors, [String], null: false

  def authorized?(id:, name: nil, parent_id: nil, position: nil)
    type_name, record_id = GraphQL::Schema::UniqueWithinType.decode(id)

    record = "Lia::#{type_name}".constantize.find_by(id: record_id)
    return true if current_ability.can?(:update, record)

    [false, { errors: ['Permission Denied. You are not allowed to perform this action.'] }]
  end

  def resolve(id:, name: nil, parent_id: nil, position: 1)
    type_name, record_id = GraphQL::Schema::UniqueWithinType.decode(id)

    record = "Lia::#{type_name}".constantize.find_by(id: record_id)
    attributes = {
      name: name,
      parent_id: parent_id,
      position: position
    }

    if record.update(attributes)
      { section: record, errors: record.errors.full_messages }
    else
      { section: nil, errors: record.errors.full_messages }
    end
  end
end
