# frozen_string_literal: true

module Types
  class Section < Types::LiaBaseObject
    description 'Section record'

    global_id_field :id

    field :parent_id, ID, null: true
    field :position, Integer, null: false

    field :name, String, null: false
    field :ancestry, String, null: true

    field :parent_id, ID, null: true
    field :parent, self, null: true

    field :root_id, ID, null: true
    field :root, self, null: true

    field :ancestor_ids, [ID], null: true
    field :ancestors, [self], null: true

    field :child_ids, [ID], null: true
    field :children, [self], null: true

    field :descendant_ids, [ID], null: true
    field :descendants, [self], null: true

    field :path_ids, [ID], null: true
    field :path, [self], null: true
  end
end
