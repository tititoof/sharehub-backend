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
  # Returns the JSON Profile object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class CitySerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :name, :latitude, :longitude
  end
end
