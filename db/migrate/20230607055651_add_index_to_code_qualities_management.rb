class AddIndexToCodeQualitiesManagement < ActiveRecord::Migration[7.0]
  def change
    add_index :code_qualities_managements, [:project_id, :project_name], unique: true, name: "cq_managements_index_on_project_id_and_project_name"
  end
end
