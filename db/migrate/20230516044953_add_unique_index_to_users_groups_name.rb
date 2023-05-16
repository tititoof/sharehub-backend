class AddUniqueIndexToUsersGroupsName < ActiveRecord::Migration[7.0]
  def change
    add_index :users_groups, :name, unique: true
  end
end
