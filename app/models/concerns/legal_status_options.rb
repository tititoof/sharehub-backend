# frozen_string_literal: true

# The Albumable module is a behavior module that can be included in an ActiveRecord model.
# It extends the model with a polymorphic association "has_many :albums, as: :albumable" that allows a model
# to be associated with multiple albums. The polymorphic key "as: :albumable" allows different models to share
# the same database table for albums, storing both the parent model's ID and type.
# The "dependent: :destroy" option ensures that all albums associated with this parent model are
# deleted from the database when the parent model is destroyed.
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
