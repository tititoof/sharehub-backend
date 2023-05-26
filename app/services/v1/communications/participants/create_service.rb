# frozen_string_literal: true

module V1
  module Communications
    module Participants
      # Create a participant for the conversation with the specified properties.
      #
      # conversation - The conversation object
      # member - The group or the user to add in conversation
      #
      # Returns the newly created Participant object if the record was saved successfully,
      # or error if validation failed.
      class CreateService < ApplicationCallable
        attr_reader :conversation, :member

        def initialize(conversation, member)
          @conversation = conversation
          @member       = member
        end

        def call
          participant = ::Communications::Participant.create!(member: @member, conversation: @conversation)

          { success: true, payload: participant }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
