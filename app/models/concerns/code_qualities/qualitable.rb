# frozen_string_literal: true

# The Qualitable module is a behavior module that can be included in an ActiveRecord model.
# It extends the model with a polymorphic association "has_many :albums, as: :qua" that allows a model
# to be associated with multiple albums. The polymorphic key "as: :albumable" allows different models to share
# the same database table for albums, storing both the parent model's ID and type.
# The "dependent: :destroy" option ensures that all albums associated with this parent model are
# deleted from the database when the parent model is destroyed.
module CodeQualities
  module Qualitable
    extend ActiveSupport::Concern
  
    included do
      has_many :managements, as: :qualitable, class_name: '::CodeQualities::Management', dependent: :destroy
    end
  end
end
  