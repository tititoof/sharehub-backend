# == Schema Information
#
# Table name: source_controls_giteas
#
#  id              :uuid             not null, primary key
#  access_token    :string
#  api_url         :string
#  ip_address      :string
#  name            :string
#  port            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_source_controls_giteas_on_organization_id           (organization_id)
#  index_source_controls_giteas_on_organization_id_and_name  (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
FactoryBot.define do
  factory :source_controls_gitea, class: 'SourceControls::Gitea' do
    api_url { Faker::Internet.url }
    access_token { Faker::Internet.uuid }
    ip_address { Faker::Internet.ip_v4_address }
    name { Faker::FunnyName.name }
    port { Faker::Number.number(digits: 4) }
    organization { FactoryBot.create(:organization) }
  end
end
