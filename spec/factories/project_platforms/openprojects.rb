# == Schema Information
#
# Table name: project_platforms_openprojects
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
#  index_project_platforms_openprojects_on_organization_id  (organization_id)
#  openprojects_index_on_organization_id_and_name           (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
FactoryBot.define do
  factory :project_platforms_openproject, class: 'ProjectPlatforms::Openproject' do
    name { Faker::FunnyName.name }
    api_url { Faker::Internet.url }
    organization { FactoryBot.create(:organization) }
    access_token { Faker::Internet.uuid }
  end
end
