class AddOrganizationToProjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :organization, null: false, foreign_key: { to_table: :organizations }, type: :uuid
  end
end
