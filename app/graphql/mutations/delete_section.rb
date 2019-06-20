# frozen_string_literal: true

class Mutations::DeleteSection < Mutations::Base
  null true

  argument :id, ID, required: true

  field :section, Types::Section, null: true
  field :errors, [String], null: false

  def authorized?(id:)
    type_name, record_id = GraphQL::Schema::UniqueWithinType.decode(id)

    record = "Lia::#{type_name}".constantize.find_by(id: record_id)
    return true if current_ability.can?(:delete, record)

    [false, { errors: ['Permission Denied. You are not allowed to perform this action.'] }]
  end

  def resolve(id:)
    type_name, record_id = GraphQL::Schema::UniqueWithinType.decode(id)

    record = "Lia::#{type_name}".constantize.find_by(id: record_id)
    record.destroy

    if record.persisted?
      { section: record, errors: record.errors.full_messages }
    else
      { section: nil, errors: [] }
    end
  end
end
