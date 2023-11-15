# == Schema Information
#
# Table name: organizations
#
#  id                   :uuid             not null, primary key
#  activity_description :text
#  activity_sector      :string
#  address              :string
#  annual_turnover      :float
#  borned_at            :date
#  email_address        :string
#  kind                 :string
#  legal_status         :string
#  name                 :string
#  number_of_employees  :integer
#  phone_number         :string
#  region               :string
#  registration_number  :string
#  website              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  admin_id             :uuid             not null
#  city_id              :uuid             not null
#  country_id           :uuid             not null
#
# Indexes
#
#  index_organizations_on_admin_id    (admin_id)
#  index_organizations_on_city_id     (city_id)
#  index_organizations_on_country_id  (country_id)
#  index_organizations_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => users.id)
#  fk_rails_...  (city_id => location_cities.id)
#  fk_rails_...  (country_id => location_countries.id)
#
FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    kind { 'sole_trader' }
    borned_at { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    address { Faker::Address.full_address }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    email_address { Faker::Internet.email }
    website { Faker::Internet.url }
    activity_description { Faker::Books::Lovecraft.paragraph }
    activity_sector { 'agriculture_forestry' }
    annual_turnover { rand(100.0..5000.0) }
    number_of_employees { rand(1..500) }
    legal_status { 'entreprise' }
    registration_number { Faker::Bank.account_number }
    region { "MyString" }
    country { FactoryBot.create(:location_country) }
    city { FactoryBot.create(:location_city) }
    admin { FactoryBot.create(:user) }
  end
end
