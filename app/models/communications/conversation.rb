# frozen_string_literal: true

# == Schema Information
#
# Table name: communications_conversations
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Communications
  # Conversation is an ActiveRecord model representing a Conversation.
  class Conversation < ApplicationRecord
    # ----------------------------------
    # --- Constants ---
    # ----------------------------------
    # CLASS_NAME
    CLASS_NAME = '::Communications::Participant'

    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Messages - has_many
    has_many :messages, class_name: '::Communications::Message', dependent: :destroy

    # Participants (Conversation)
    has_many :conversations_participants,
             class_name: '::Communications::Participant',
             dependent: :destroy

    # Groups - has_many
    has_many :groups,
             through: :conversations_participants,
             source: :member,
             source_type: CLASS_NAME,
             class_name: '::Users::Group'

    # Users - has_many
    has_many :users,
             through: :conversations_participants,
             source: :member,
             source_type: 'User',
             class_name: '::User'

    # Groups admins - has_many
    has_many :admins,
             through: :groups,
             source: :admin,
             class_name: '::User'

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Name
    validates :name, presence: { message: :required }
    validates :name,
              length: { in: 4..60, too_long: :tooLong,
                        too_short: :tooShort }
  end
end
