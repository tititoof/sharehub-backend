class AddIndexToProjectPlatformsManagement < ActiveRecord::Migration[7.0]
  def change
    add_index :project_platforms_managements, [:project_id, :project_name], unique: true, name: "managements_index_on_project_id_and_project_name"
  end
end
