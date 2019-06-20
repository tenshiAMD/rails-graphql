# frozen_string_literal: true

require 'lia/sunspot/helpers'

module Types
  class QueryType < Types::LiaBaseObject
    include Lia::Sunspot::Helpers

    field :me, Types::User, null: false, description: 'Returns the current user'

    def me
      Lia.user_class.first
    end

    field :users, [Types::User], null: true, description: 'Returns records for `users`' do
      argument :id, [ID], required: false
      argument :limit, Int, required: false
    end

    def users(id: nil, limit: nil)
      records = Lia.user_class.limit(limit)
      records = records.where(id: id) if id.present?
      records
    end

    field :subjects, [Types::Subject], null: true, description: 'Returns records for `subjects`' do
      argument :id, [ID], required: false
      argument :limit, Int, required: false
      argument :name, String, required: false
    end

    def subjects(id: nil, limit: nil, name: nil)
      records = Lia::Subject.limit(limit)
      records = records.where(id: id) if id.present?
      records = records.where(name: name) if name.present?
      records
    end

    field :subject, Types::Subject, null: true do
      argument :id, ID, required: true
    end

    def subject(id:)
      Lia::Subject.find(id)
    end

    field :sections, [Types::Section], null: true, description: 'Returns records for `sections`' do
      argument :id, [ID], required: false
      argument :limit, Int, required: false
    end

    def sections(id: nil, limit: nil)
      records = Lia::Section.limit(limit)
      records = records.where(id: id) if id.present?
      records
    end

    field :section, Types::Section, null: true do
      argument :id, ID, required: true
    end

    def section(id:)
      Lia::Section.find(id)
    end

    field :documents, [Types::Document], null: true, extensions: [Extensions::Search],
                                         description: 'Returns records for `documents`' do
      argument :id, [ID], required: false
    end

    field :documents_solr, [Types::Document], null: true, extensions: [Extensions::Search],
                                              description: 'Returns records for `documents`' do
      argument :id, [ID], required: false
    end

    def documents(id: nil, q: nil)
      fulltext_fields = %i[issuance_no title content]

      search = Lia::Document.search do
        if q.present?
          fulltext q do
            fields issuance_no: 6.0, title: 5.0, content: 2.0

            highlight :issuance_no
            highlight :title
            highlight :content, max_snippets: 3, fragment_size: 100

            query_phrase_slop 0
          end
        end
      end

      search.results.each do |result|
        result.issuance_no = solr_highlight_field search, result, :issuance_no
        result.title = solr_highlight_field search, result, :title
        result.content = solr_snippet_field search, result, :content
      end

      # search.hits.each do |hit|
      #   next if hit.instance.blank?
      #
      #   fulltext_fields.each do |field|
      #     hit.highlights(field).each do |highlight|
      #       highlighted_text = highlight.format do |word|
      #         ['<span class="match-matcher">', word, "</span>"].join
      #       end
      #
      #       hit.instance.send("#{field.to_s}=", highlighted_text)
      #     end
      #   end
      # end

      search.results
    end
    alias documents_solr documents

    field :document, Types::Document, null: true, extensions: [Extensions::Search],
                                      description: 'Returns a particular document' do
      argument :id, ID, required: false
    end

    field :document_solr, Types::Document, null: true, extensions: [Extensions::Search],
                                           description: 'Returns a particular document' do
      argument :id, ID, required: false
    end

    def document(id: nil, q: nil)
      opts = { 'hl.maxAnalyzedChars': -1, 'hl.maxAlternateFieldLength': -1 }

      search = Lia::Document.search do
        adjust_solr_params do |params|
          params.deep_merge(opts)
        end

        if q.present?
          fulltext q do
            fields :content

            highlight :content, fragment_size: 0

            query_phrase_slop 0
          end
        end
      end

      search.results.each do |result|
        result.content = solr_highlight_field search, result, :content
      end

      search.results.first
    end
    alias document_solr document

    field :all_documents, function: Resolvers::DocumentsSearch
  end
end
