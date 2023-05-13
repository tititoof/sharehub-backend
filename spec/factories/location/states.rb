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
FactoryBot.define do
  factory :location_state, class: 'Location::State' do
    name { "CVL" }
    code { rand(1..5000) }
    country { FactoryBot.create(:location_country) }
  end
end
