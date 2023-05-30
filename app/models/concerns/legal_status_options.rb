# frozen_string_literal: true

# The LegalStatusOptions enums
module LegalStatusOptions
  extend ActiveSupport::Concern

  included do
    enum legal_status_options: {
      entreprise: :entreprise,
      association_status: :association_status,
      cooperative_status: :cooperative_status,
      ngo: :ngo,
      union: :union,
      foundation: :foundation,
      other_status: :other_status
    }
  end
end
