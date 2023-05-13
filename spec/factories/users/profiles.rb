# == Schema Information
#
# Table name: users_profiles
#
#  id            :uuid             not null, primary key
#  address       :string
#  date_of_birth :date
#  email         :string
#  first_name    :string
#  last_name     :string
#  nickname      :string
#  phone         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  city_id       :uuid
#  user_id       :uuid             not null
#
# Indexes
#
#  index_users_profiles_on_city_id   (city_id)
#  index_users_profiles_on_nickname  (nickname) UNIQUE
#  index_users_profiles_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => location_cities.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :users_profile, class: 'Users::Profile' do
    first_name { Faker::Games::DnD.first_name }
    last_name { Faker::Games::DnD.last_name }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.email }
    date_of_birth { Faker::Date.between(from: '1980-09-23', to: '2000-09-25') }
    nickname { Faker::Games::DnD.first_name }
    city { FactoryBot.create(:location_city) }
    user { FactoryBot.create(:user) }
  end
end
