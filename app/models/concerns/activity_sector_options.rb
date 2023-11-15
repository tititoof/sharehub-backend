# frozen_string_literal: true

# The ActivitySectorOptions enums
module ActivitySectorOptions
  extend ActiveSupport::Concern

  included do
    attribute :activity_sector, :string
    enum :activity_sector, {
      agriculture_forestry: 'agriculture_forestry', # Agriculture and forestry
      energy_utilities: 'energy_utilities', # Energy and utilities
      finance_insurance: 'finance_insurance', # Finance and insurance
      government_public_sector: 'government_public_sector', # Government and public sector
      # Healthcare and pharmaceuticals
      healthcare_pharmaceuticals: 'healthcare_pharmaceuticals',
      it_telecommunications: 'it_telecommunications', # IT and telecommunications
      manufacturing_engineering: 'manufacturing_engineering', # Manufacturing and engineering
      media_entertainment: 'media_entertainment', # Media and entertainment
      nonprofit_charity: 'nonprofit_charity', # Nonprofit and charity
      real_estate_construction: 'real_estate_construction', # Real estate and construction
      retail_consumer_goods: 'retail_consumer_goods', # Retail and consumer goods
      transportation_logistics: 'transportation_logistics', # Transportation and logistics
      travel_hospitality: 'travel_hospitality', # Travel and hospitality
      other_activity: 'other_activity'
    }, validate: true
  end
end
