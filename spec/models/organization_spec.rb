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
#  city_id              :uuid             not null
#  country_id           :uuid             not null
#
# Indexes
#
#  index_organizations_on_city_id     (city_id)
#  index_organizations_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => location_cities.id)
#  fk_rails_...  (country_id => location_countries.id)
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  subject { FactoryBot.create(:organization) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without activity_description' do
    subject.activity_description = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong activity_sector' do
    subject.activity_sector = "wrong enum"

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong address' do
    subject.address = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without borned_at' do
    subject.borned_at = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without email_address' do
    subject.email_address = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong email_address' do
    subject.email_address = 'toto'

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong kind' do
    subject.kind = "it_is_not_valid"

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong legal_status' do
    subject.legal_status = "it_is_not_valid"

    expect(subject).not_to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong number_of_employees' do
    subject.number_of_employees = 1.1

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong number_of_employees' do
    subject.number_of_employees = 1.1

    expect(subject).not_to be_valid
  end
  
end
