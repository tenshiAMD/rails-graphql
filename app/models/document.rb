# frozen_string_literal: true

Lia::Document.class_eval do
  searchable do
    text :issuance_no
    text :title
    text :content

    string :issuance_no
    string :title
    string :content
  end
end
