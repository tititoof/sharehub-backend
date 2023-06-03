# == Schema Information
#
# Table name: source_controls_repositories
#
#  id             :uuid             not null, primary key
#  name           :string
#  owner          :string
#  repo           :string
#  sourcable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  project_id     :uuid             not null
#  sourcable_id   :uuid             not null
#
# Indexes
#
#  index_source_controls_repositories_on_project_id           (project_id)
#  index_source_controls_repositories_on_project_id_and_name  (project_id,name) UNIQUE
#  index_source_controls_repositories_on_sourcable            (sourcable_type,sourcable_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :source_controls_repository, class: 'SourceControls::Repository' do
    name { Faker::Company.name }
    owner { Faker::Name.initials }
    repo { Faker::Name.initials }
    project { FactoryBot.create(:project) }
    sourcable { FactoryBot.create(:source_controls_gitea) }
  end
end
