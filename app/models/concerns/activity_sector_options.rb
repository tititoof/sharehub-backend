# frozen_string_literal: true

# The Albumable module is a behavior module that can be included in an ActiveRecord model.
# It extends the model with a polymorphic association "has_many :albums, as: :albumable" that allows a model
# to be associated with multiple albums. The polymorphic key "as: :albumable" allows different models to share
# the same database table for albums, storing both the parent model's ID and type.
# The "dependent: :destroy" option ensures that all albums associated with this parent model are
# deleted from the database when the parent model is destroyed.
module ActivitySectorOptions
  extend ActiveSupport::Concern

  included do
    enum activity_sector_options: {
      agriculture_forestry: :agriculture_forestry, # Agriculture and forestry
      energy_utilities: :energy_utilities, # Energy and utilities
      finance_insurance: :finance_insurance, # Finance and insurance
      government_public_sector: :government_public_sector, # Government and public sector
      # Healthcare and pharmaceuticals
      healthcare_pharmaceuticals: :healthcare_pharmaceuticals,
      it_telecommunications: :it_telecommunications, # IT and telecommunications
      manufacturing_engineering: :manufacturing_engineering, # Manufacturing and engineering
      media_entertainment: :media_entertainment, # Media and entertainment
      nonprofit_charity: :nonprofit_charity, # Nonprofit and charity
      real_estate_construction: :real_estate_construction, # Real estate and construction
      retail_consumer_goods: :retail_consumer_goods, # Retail and consumer goods
      transportation_logistics: :transportation_logistics, # Transportation and logistics
      travel_hospitality: :travel_hospitality, # Travel and hospitality
      other_activity: :other_activity } # Other
  end
end
