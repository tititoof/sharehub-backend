class CreateGalleriesMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries_media, id: :uuid do |t|
      t.string :kind
      t.references :album, null: false, foreign_key: { to_table: :galleries_albums }, type: :uuid

      t.timestamps
    end
  end
end
