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
FactoryBot.define do
  factory :code_qualities_sonarqube, class: 'CodeQualities::Sonarqube' do
    name { Faker::FunnyName.name }
    api_url { Faker::Internet.url }
    access_token { Faker::Internet.uuid }
    organization { FactoryBot.create(:organization) }
  end
end
