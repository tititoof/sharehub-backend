# == Schema Information
#
# Table name: project_members
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :uuid             not null
#  project_id :uuid             not null
#
# Indexes
#
#  index_project_members_on_member_id   (member_id)
#  index_project_members_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => users.id)
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :project_member do
    member { FactoryBot.create(:user) }
    project { FactoryBot.create(:project) }
  end
end
