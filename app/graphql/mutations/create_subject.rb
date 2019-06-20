# frozen_string_literal: true

class Mutations::CreateSubject < Mutations::Base
  null true

  argument :name, String, required: true
  argument :parent_id, ID, required: false
  argument :position, Int, required: false

  field :subject, Types::Subject, null: true
  field :errors, [String], null: false

  def authorized?(name:, parent_id: nil, position: nil)
    return true if current_ability.can?(:create, Lia::Subject)

    [false, { errors: ['Permission Denied. You are not allowed to perform this action.'] }]
  end

  def resolve(name:, parent_id: nil, position: 1)
    record = ::Lia::Subject.new(name: name,
                                parent_id: parent_id,
                                position: position)
    if record.save
      { subject: record, errors: record.errors.full_messages }
    else
      { subject: nil, errors: record.errors.full_messages }
    end
  end
end
