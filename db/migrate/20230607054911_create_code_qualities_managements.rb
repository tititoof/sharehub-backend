class CreateCodeQualitiesManagements < ActiveRecord::Migration[7.0]
  def change
    create_table :code_qualities_managements, id: :uuid do |t|
      t.string :name
      t.string :project_name
      t.references :project, null: false, foreign_key: true, type: :uuid
      t.references :qualitable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
