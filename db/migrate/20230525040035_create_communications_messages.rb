class CreateCommunicationsMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :communications_messages, id: :uuid do |t|
      t.references :conversation, null: false, foreign_key: { to_table: :communications_conversations }, type: :uuid
      t.references :user, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.string :content

      t.timestamps
    end
  end
end
