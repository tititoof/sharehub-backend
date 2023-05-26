# frozen_string_literal: true

# == Schema Information
#
# Table name: communications_participants
#
#  id              :uuid             not null, primary key
#  member_type     :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :uuid             not null
#  member_id       :uuid             not null
#
# Indexes
#
#  index_communications_participants_on_conversation_id  (conversation_id)
#  index_communications_participants_on_member           (member_type,member_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => communications_conversations.id)
#
module Communications
  # Participant is an ActiveRecord model representing a Participant.
  class Participant < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Member
    belongs_to :member, polymorphic: true
    # Conversation
    belongs_to :conversation
  end
end
