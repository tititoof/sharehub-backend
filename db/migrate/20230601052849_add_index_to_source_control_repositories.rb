class AddIndexToSourceControlRepositories < ActiveRecord::Migration[7.0]
  def change
    add_index :source_controls_repositories, [:project_id, :name], unique: true
  end
end
