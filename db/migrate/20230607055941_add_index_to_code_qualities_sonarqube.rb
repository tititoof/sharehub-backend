class AddIndexToCodeQualitiesSonarqube < ActiveRecord::Migration[7.0]
  def change
    add_index :code_qualities_sonarqubes, [:organization_id, :name], unique: true, name: "sonarqubes_index_on_organization_id_and_name"
  end
end
