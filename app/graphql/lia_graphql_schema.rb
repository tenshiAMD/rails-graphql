# frozen_string_literal: true

class LiaGraphqlSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # default_max_page_size 10

  def self.id_from_object(object, type_definition, _query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.graphql_name, object.id)
  end

  def self.object_from_id(node_id, _ctx)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(node_id)

    Object.const_get("Lia::#{type_name}").find(item_id)
  end

  def self.resolve_type(_type, obj, _ctx)
    klass = "::Types::#{obj.class.to_s.gsub('Lia::', '')}"
    defined?(klass) ? klass.constantize : raise("Unexpected object: #{obj}")
  end

  def self.unauthorized_object(error)
    raise GraphQL::ExecutionError, "An object of type #{error.type.graphql_name} was hidden due to permissions"
  end

  def self.unauthorized_field(error)
    raise GraphQL::ExecutionError, "The field #{error.field.graphql_name} on an object of type #{error.type.graphql_name} was hidden due to permissions"
  end
end
