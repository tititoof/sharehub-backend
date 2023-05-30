class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title
      t.text :description
      t.date :start_at
      t.date :end_at
      t.string :status
      t.references :manager, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.string :external_references
      t.string :category

      t.timestamps
    end
  end
end
