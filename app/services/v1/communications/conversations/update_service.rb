# frozen_string_literal: true

module V1
  module Communications
    module Conversations
      # Update a conversation with the specified properties.
      #
      # conversation - The conversation object to update
      # properties - A Hash of attributes to set on the new conversation. The allowed keys are:
      #              - :name - the name of the conversation.
      #
      # Returns the updated Conversation object if the record was saved successfully,
      # or error if validation failed.
      class UpdateService < ApplicationCallable
        attr_reader :conversation, :properties

        def initialize(conversation, properties)
          @conversation = conversation
          @properties   = properties
        end

        def call
          @conversation.update!(name: @properties[:name])

          { success: true, payload: @conversation }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
