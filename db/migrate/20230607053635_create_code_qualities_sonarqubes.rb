class CreateCodeQualitiesSonarqubes < ActiveRecord::Migration[7.0]
  def change
    create_table :code_qualities_sonarqubes, id: :uuid do |t|
      t.string :access_token
      t.string :api_url
      t.string :name
      t.references :organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
