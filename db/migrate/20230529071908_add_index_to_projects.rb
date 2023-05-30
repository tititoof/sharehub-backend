class AddIndexToProjects < ActiveRecord::Migration[7.0]
  def change
    add_index :projects, [:organization_id, :title], unique: true
  end
end
