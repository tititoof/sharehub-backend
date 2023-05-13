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
  # Returns the JSON State object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class StateSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :name, :country_id
  end
end
