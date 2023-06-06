# frozen_string_literal: true

# == Schema Information
#
# Table name: communications_messages
#
#  id              :uuid             not null, primary key
#  content         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :uuid             not null
#  user_id         :uuid             not null
#
# Indexes
#
#  index_communications_messages_on_conversation_id  (conversation_id)
#  index_communications_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => communications_conversations.id)
#  fk_rails_...  (user_id => users.id)
#
module Communications
  # Message is an ActiveRecord model representing a Message.
  class Message < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Conversation
    belongs_to :conversation, class_name: '::Communications::Conversation'

    # User - belongs to
    belongs_to :user, class_name: 'User'

    # File - has one (ActiveStorage)
    has_one_attached :file

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Name
    validates :content, presence: { message: :required }
    validates :content,
              length: { in: 4..250, too_long: :tooLong,
                        too_short: :tooShort }
  end
end
