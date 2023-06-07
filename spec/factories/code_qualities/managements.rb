# == Schema Information
#
# Table name: code_qualities_managements
#
#  id              :uuid             not null, primary key
#  name            :string
#  project_name    :string
#  qualitable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :uuid             not null
#  qualitable_id   :uuid             not null
#
# Indexes
#
#  cq_managements_index_on_project_id_and_project_name  (project_id,project_name) UNIQUE
#  index_code_qualities_managements_on_project_id       (project_id)
#  index_code_qualities_managements_on_qualitable       (qualitable_type,qualitable_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :code_qualities_management, class: 'CodeQualities::Management' do
    name { Faker::Company.name }
    project_name { Faker::FunnyName.name }
    project { FactoryBot.create(:project) }
    qualitable { FactoryBot.create(:code_qualities_sonarqube) }
  end
end
