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
require 'rails_helper'

RSpec.describe Location::Country, type: :model do
  subject { FactoryBot.create(:location_country) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without latitude' do
    subject.latitude = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without longitude' do
    subject.longitude = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without emoji' do
    subject.emoji = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without code' do
    subject.code = nil

    expect(subject).not_to be_valid
  end
end
