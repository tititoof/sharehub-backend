class AddAdminReferencesFieldToOrganizationsTable < ActiveRecord::Migration[7.0]
  def change
    add_reference :organizations, :admin, null: false, foreign_key: { to_table: :users }, type: :uuid
  end
end
