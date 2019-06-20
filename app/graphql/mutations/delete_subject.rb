# frozen_string_literal: true

class Mutations::DeleteSubject < Mutations::Base
  null true

  argument :id, ID, required: true

  field :subject, Types::Subject, null: true
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
      { subject: record, errors: record.errors.full_messages }
    else
      { subject: nil, errors: [] }
    end
  end
end
