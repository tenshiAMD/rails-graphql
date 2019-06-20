# frozen_string_literal: true

require 'search_object/plugin/graphql'
require 'graphql/query_resolver'

class Resolvers::DocumentsSearch
  include SearchObject.module(:graphql)

  scope { Lia::Document.all }
  type types[Types::Document]

  class DocumentFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :title_contains, String, required: false
    argument :content_contains, String, required: false
  end

  option :filter, type: DocumentFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :last, type: types.Int, with: :apply_last
  option :skip, type: types.Int, with: :apply_skip
  option :orderBy, type: types.String, with: :apply_order_by, default: 'created_at DESC'

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Lia::Document.all
    scope = scope.where('title LIKE ?', "%#{value[:title_contains]}%") if value[:title_contains]
    scope = scope.where('content LIKE ?', "%#{value[:content_contains]}%") if value[:content_contains]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end

  def apply_first(scope, value)
    scope.first(value)
  end

  def apply_last(scope, value)
    scope.last(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def apply_order_by(scope, value)
    scope.order(value)
  end

  def fetch_results
    # NOTE: Don't run QueryResolver during tests
    return super unless context.present?

    GraphQL::QueryResolver.run(Lia::Document, context, Types::Document) do
      super
    end
  end
end
