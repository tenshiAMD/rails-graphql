# frozen_string_literal: true

Lia.user_class.class_eval do
  searchable do
    text :name

    string :name
  end
end
