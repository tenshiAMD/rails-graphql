# frozen_string_literal: true

if defined?(Lia)
  Lia.configure do |config|
    DOCUMENT_FIELDS = %w[
      side_by_side
      subject
      subject_ids
      signatory
      committee
      councilor
      parties
      division_id
      ponente
      members_of_division
      attachments
      case_status
    ].freeze

    config.document_fields = DOCUMENT_FIELDS if DOCUMENT_FIELDS.present?

    config.enable_document_links = true
    config.enable_document_pdfs = true
    config.user_class = 'Lia::User'
  end
end

module Lia
  class DefaultAbility
    include CanCan::Ability

    attr_reader :user, :document_fields

    def initialize(ability)
      return if ability.blank?

      @user = ability.user
      @document_fields = ability.document_fields

      set_default_abilities

      if user.has_any_role?(:editor, :special_editor)
        resources = [Document, Section]
        resources << CourtDivision if document_fields.include?('division_id')
        resources << Document::FileSource if document_fields.include?('attachments')
        resources << Subject if document_fields.include?('subject_ids')

        can :delete, resources do |subject|
          subject.paper_trail_originator.to_i == user.id
        end

        can :delete, resources if user.has_role?(:special_editor)
      end

      resources << User if user.has_role?(:users_manager)
      can :basic_manage, resources

      can :manage, :all if user.has_role?(:system_administrator)

      cannot :destroy, User
    end

    private

    def set_default_abilities
      can %i[display full_view], Document
      can :email, Document do |subject|
        can?(:read, subject) && subject.publish
      end

      can %i[read list menu indexes], Section if document_fields.include?('section_ids')
      can %i[read list menu indexes], Subject if document_fields.include?('subject_ids')
      can :index, CourtDivision if document_fields.include?('division_id')

      resources = [Document::ContentPdf] if Lia.enable_document_pdfs
      resources << Document::FileSource if document_fields.include?('attachments')
      can %i[read download], resources do |subject|
        can?(:read, subject.document)
      end

      can :change_pwd, user
    end

    Lia.abilities.register_ability(self)
  end
end
