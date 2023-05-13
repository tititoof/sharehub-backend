class AddUniqueIndexToProfilesNickname < ActiveRecord::Migration[7.0]
  def change
    add_index :users_profiles, :nickname, unique: true
  end
end
