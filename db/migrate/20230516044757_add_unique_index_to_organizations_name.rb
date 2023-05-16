class AddUniqueIndexToOrganizationsName < ActiveRecord::Migration[7.0]
  def change
    add_index :organizations, :name, unique: true
  end
end
