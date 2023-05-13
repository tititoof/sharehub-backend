# frozen_string_literal: true

# == Schema Information
#
# Table name: location_states
#
#  id         :uuid             not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :uuid             not null
#
# Indexes
#
#  index_location_states_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => location_countries.id)
#
module Location
  # This class represents a state or province in a country.
  class State < ApplicationRecord
    # --- Relations ---
    # Country - belongs to
    belongs_to :country, class_name: 'Location::Country'
    # Cities - has many - destroy cities on destroy country
    has_many :cities, class_name: 'Location::City', dependent: :destroy

    # --- Validations ---
    # Name
    validates :name, presence: true
    # Code
    validates :code, presence: true
  end
end
