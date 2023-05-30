class CreateProjectMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :project_members, id: :uuid do |t|
      t.references :member, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :project, null: false, foreign_key: { to_table: :projects }, type: :uuid

      t.timestamps
    end
  end
end
