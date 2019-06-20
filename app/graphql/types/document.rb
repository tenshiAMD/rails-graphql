# frozen_string_literal: true

module Types
  class Document < Types::LiaBaseObject
    description 'Document record'

    global_id_field :id

    field :court_division_id, ID, null: true

    field :section_ids, [ID], null: true
    field :sections, [Types::Section], null: true

    field :subject_ids, [ID], null: true
    field :subjects, [Types::Subject], null: true

    field :issuance_no, String, null: true
    field :title, String, null: true
    field :signatory, String, null: true
    field :committee, String, null: true
    field :councilor, String, null: true
    field :author, String, null: true
    field :author, String, null: true
    field :members_of_division, String, null: true
    field :ponente, String, null: true
    field :subject, String, null: true
    field :parties, String, null: true
    field :case_status, String, null: true
    field :doc_date, String, null: true
    field :content, String, null: true

    field :doc_year, Int, null: true

    field :publish, Boolean, null: true
  end
end
