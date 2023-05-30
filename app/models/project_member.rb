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
class ProjectMember < ApplicationRecord
  # ----------------------------------
  # --- Relations ---
  # ----------------------------------
  # Member (user) - belongs to
  belongs_to :member, class_name: 'User'

  # Project - belongs to
  belongs_to :project
end
