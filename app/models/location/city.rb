# frozen_string_literal: true

# == Schema Information
#
# Table name: location_cities
#
#  id         :uuid             not null, primary key
#  latitude   :string
#  longitude  :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :uuid             not null
#  state_id   :uuid             not null
#
# Indexes
#
#  index_location_cities_on_country_id  (country_id)
#  index_location_cities_on_state_id    (state_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => location_countries.id)
#  fk_rails_...  (state_id => location_states.id)
#
module Location
  # City is an ActiveRecord model representing a city.
  class City < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Country - belongs to
    belongs_to :country, class_name: 'Location::Country'

    # State - belongs to
    belongs_to :state, class_name: 'Location::State'

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Name
    validates :name, presence: true

    # Latitude
    validates :latitude, presence: true

    # Longitude
    validates :longitude, presence: true
  end
end
