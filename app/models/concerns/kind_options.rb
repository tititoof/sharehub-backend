# frozen_string_literal: true

# The Albumable module is a behavior module that can be included in an ActiveRecord model.
# It extends the model with a polymorphic association "has_many :albums, as: :albumable" that allows a model
# to be associated with multiple albums. The polymorphic key "as: :albumable" allows different models to share
# the same database table for albums, storing both the parent model's ID and type.
# The "dependent: :destroy" option ensures that all albums associated with this parent model are
# deleted from the database when the parent model is destroyed.
module KindOptions
  extend ActiveSupport::Concern

  included do
    enum kind_options: {
      sole_trader: :sole_trader, # Entreprise individuelle
      single_member_llc: :single_member_llc, # Entreprise unipersonnelle à responsabilité limitée (EURL)
      llc: :llc, # Société à responsabilité limitée (SARL)
      sa: :sa, # Société anonyme (SA)
      general_partnership: :general_partnership, # Société en nom collectif (SNC)
      limited_partnership: :limited_partnership, # Société en commandite simple (SCS)
      partnership_limited_by_shares: :partnership_limited_by_shares, # Société en commandite par actions (SCA)
      association: :association, # Association
      cooperative: :cooperative, # Coopérative
      non_profit_organization: :non_profit_organization, # Organisme sans but lucratif (OSBL)
      public_administration: :public_administration, # Administration publique
      other_kind: :other_kind
    }
  end
end
