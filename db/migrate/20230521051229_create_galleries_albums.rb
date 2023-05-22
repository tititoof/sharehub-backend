class CreateGalleriesAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries_albums, id: :uuid do |t|
      t.references :albumable, polymorphic: true, null: false, type: :uuid
      t.string :title
      t.text :description
      t.string :aasm_state

      t.timestamps
    end
  end
end
