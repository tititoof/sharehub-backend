class CreateSourceControlsRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :source_controls_repositories, id: :uuid do |t|
      t.string :name
      t.string :owner
      t.string :repo
      t.references :project, null: false, foreign_key: { to_table: :projects }, type: :uuid
      t.references :sourcable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
