# frozen_string_literal: true

module V1
  module Communications
    module Conversations
      # Create a conversation with the specified properties.
      #
      # member - The group or the user to add in conversation
      # properties - A Hash of attributes to set on the new conversation. The allowed keys are:
      #              - :name - the name of the conversation.
      #
      # Returns the newly created Conversation object if the record was saved successfully,
      # or error if validation failed.
      class CreateProcedure < ApplicationCallable
        attr_reader :member, :properties

        def initialize(member, properties)
          @member     = member
          @properties = properties
        end

        def call
          resource = V1::Communications::Conversations::CreateService.call(@properties)

          raise ArgumentError, 'conversation.notCreated' if resource[:success] == false

          V1::Communications::Participants::CreateService.call(resource[:payload], @member)

          { success: true, payload: resource[:payload] }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        rescue ArgumentError => e
          { success: false, errors: e.message, status: :unprocessable_entity }
        end
      end
    end
  end
end
