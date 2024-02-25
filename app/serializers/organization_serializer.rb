# frozen_string_literal: true

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

# Returns the JSON Organization object.
#
# set_key_transform :camel_lower - "some_key" => "someKey"
class OrganizationSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower

  attributes :id, :activity_description, :activity_sector, :address, :annual_turnover,
             :borned_at, :email_address, :kind, :legal_status, :name, :number_of_employees,
             :phone_number, :registration_number, :website, :city_id, :country_id

  attribute :state_id do |object|
    object&.city&.state&.id
  end
end
