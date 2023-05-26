class CreateCommunicationsParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :communications_participants, id: :uuid do |t|
      t.references :member, polymorphic: true, null: false, type: :uuid
      t.references :conversation, null: false, foreign_key: { to_table: :communications_conversations }, type: :uuid

      t.timestamps
    end
  end
end
