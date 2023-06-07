# == Schema Information
#
# Table name: code_qualities_sonarqubes
#
#  id              :uuid             not null, primary key
#  access_token    :string
#  api_url         :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_code_qualities_sonarqubes_on_organization_id  (organization_id)
#  sonarqubes_index_on_organization_id_and_name        (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
require 'rails_helper'

RSpec.describe CodeQualities::Sonarqube, type: :model do
  subject { FactoryBot.create(:code_qualities_sonarqube) }
  
  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without access_token' do
      subject.access_token = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without api_url' do
      subject.api_url = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without organization' do
      subject.organization = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:organization).class_name('::Organization') }
  end
end
