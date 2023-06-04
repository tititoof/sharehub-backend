# == Schema Information
#
# Table name: project_platforms_managements
#
#  id                :uuid             not null, primary key
#  name              :string
#  platformable_type :string           not null
#  project_name      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  platformable_id   :uuid             not null
#  project_id        :uuid             not null
#
# Indexes
#
#  index_project_platforms_managements_on_platformable  (platformable_type,platformable_id)
#  index_project_platforms_managements_on_project_id    (project_id)
#  managements_index_on_project_id_and_project_name     (project_id,project_name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :project_platforms_management, class: 'ProjectPlatforms::Management' do
    name { Faker::Company.name }
    project_name { Faker::FunnyName.name }
    project { FactoryBot.create(:project) }
    platformable { FactoryBot.create(:project_platforms_openproject) }
  end
end
