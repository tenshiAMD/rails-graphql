# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_section, mutation: Mutations::CreateSection
    field :update_section, mutation: Mutations::UpdateSection
    field :delete_section, mutation: Mutations::DeleteSection

    field :create_subject, mutation: Mutations::CreateSubject
    field :update_subject, mutation: Mutations::UpdateSubject
    field :delete_subject, mutation: Mutations::DeleteSubject
  end
end
