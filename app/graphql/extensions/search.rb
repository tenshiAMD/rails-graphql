# frozen_string_literal: true

module Extensions
  class Search < GraphQL::Schema::FieldExtension
    def apply
      field.argument(:q, String, required: false, description: 'A search query')
    end
  end
end
