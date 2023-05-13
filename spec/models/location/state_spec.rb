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
require 'rails_helper'

RSpec.describe Location::State, type: :model do
  subject { FactoryBot.create(:location_state) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without code' do
    subject.code = nil

    expect(subject).not_to be_valid
  end
end
