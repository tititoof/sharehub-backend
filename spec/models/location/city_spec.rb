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
require 'rails_helper'

RSpec.describe Location::City, type: :model do
  subject { FactoryBot.create(:location_city) }

  describe 'attributs' do
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
  end

  describe 'associations' do
    it { should belong_to(:country).class_name('::Location::Country') }
    it { should belong_to(:state).class_name('::Location::State') }
  end
end
