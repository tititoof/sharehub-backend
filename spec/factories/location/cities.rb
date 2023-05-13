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
FactoryBot.define do
  factory :location_city, class: 'Location::City' do
    name { Faker::Games::DnD.city }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    country { FactoryBot.create(:location_country) }
    state { FactoryBot.create(:location_state) }
  end
end
