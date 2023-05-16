class CreateUsersGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :users_groups, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :kind
      t.references :admin, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :organization, null: false, foreign_key: { to_table: :organizations }, type: :uuid

      t.timestamps
    end
  end
end
