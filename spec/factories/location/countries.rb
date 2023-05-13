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
FactoryBot.define do
  factory :location_country, class: 'Location::Country' do
    name { "France" }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    emoji { Faker::Nation.flag }
    code { rand(1..5000) }
  end
end
