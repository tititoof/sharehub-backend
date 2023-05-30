# == Schema Information
#
# Table name: projects
#
#  id                  :uuid             not null, primary key
#  category            :string
#  description         :text
#  end_at              :date
#  external_references :string
#  start_at            :date
#  status              :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  manager_id          :uuid             not null
#  organization_id     :uuid             not null
#
# Indexes
#
#  index_projects_on_manager_id                 (manager_id)
#  index_projects_on_organization_id            (organization_id)
#  index_projects_on_organization_id_and_title  (organization_id,title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (manager_id => users.id)
#  fk_rails_...  (organization_id => organizations.id)
#

# Returns the JSON Project object.
#
# set_key_transform :camel_lower - "some_key" => "someKey"
class ProjectSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower

  attributes :id, :category, :description, :end_at, :external_references, :start_at, :status,
             :title, :manager_id, :organization_id
end
