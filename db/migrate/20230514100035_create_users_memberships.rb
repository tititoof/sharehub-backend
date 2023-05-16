class CreateUsersMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :users_memberships, id: :uuid do |t|
      t.references :member, polymorphic: true, null: false, type: :uuid
      t.references :joinable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
