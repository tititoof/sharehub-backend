# frozen_string_literal: true

# == Schema Information
#
# Table name: location_countries
#
#  id         :uuid             not null, primary key
#  code       :string
#  emoji      :string
#  latitude   :float
#  longitude  :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_location_countries_on_code  (code) UNIQUE
#
module Location
  # Country model representing a country in the world.
  # It has many associated states and cities.
  class Country < ApplicationRecord
    # --- Relations ---
    # States - has many - destroy states on destroy country
    has_many :states, class_name: 'Location::State', dependent: :destroy
    # Cities - has many - destroy cities on destroy country
    has_many :cities, class_name: 'Location::City', dependent: :destroy

    # --- Validations ---
    # Name
    validates :name, presence: true
    # Latitude
    validates :latitude, presence: true
    # Longitude
    validates :longitude, presence: true
    # Emoji
    validates :emoji, presence: true
    # Code
    validates :code, presence: true
  end
end
