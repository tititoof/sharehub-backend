class CreateProjectPlatformsOpenprojects < ActiveRecord::Migration[7.0]
  def change
    create_table :project_platforms_openprojects, id: :uuid do |t|
      t.string :name
      t.string :api_url
      t.references :organization, null: false, foreign_key: { to_table: :organizations }, type: :uuid
      t.string :access_token

      t.timestamps
    end
  end
end
