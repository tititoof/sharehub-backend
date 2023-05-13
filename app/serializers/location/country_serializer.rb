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
  # Returns the JSON Country object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class CountrySerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :name, :emoji
  end
end
