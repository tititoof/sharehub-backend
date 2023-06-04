class AddNameAndOrganizationToSourceControlsGitea < ActiveRecord::Migration[7.0]
  def change
    add_column :source_controls_giteas, :name, :string
    add_reference :source_controls_giteas, :organization, null: false, foreign_key: { to_table: :organizations }, type: :uuid
    add_index :source_controls_giteas, [:organization_id, :name], unique: true
  end
end
