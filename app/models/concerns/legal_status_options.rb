# frozen_string_literal: true

# The LegalStatusOptions enums
module LegalStatusOptions
  extend ActiveSupport::Concern

  included do
    attribute :legal_status, :string
    enum :legal_status, {
      entreprise: 'entreprise',
      association_status: 'association_status',
      cooperative_status: 'cooperative_status',
      ngo: 'ngo',
      union: 'union',
      foundation: 'foundation',
      other_status: 'other_status'
    }, validate: true
  end
end
