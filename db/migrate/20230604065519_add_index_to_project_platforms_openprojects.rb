class AddIndexToProjectPlatformsOpenprojects < ActiveRecord::Migration[7.0]
  def change
    add_index :project_platforms_openprojects, [:organization_id, :name], unique: true, name: "openprojects_index_on_organization_id_and_name"
  end
end
