# frozen_string_literal: true

module V1
  module Communications
    module Conversations
      # Create a conversation with the specified properties.
      #
      # properties - A Hash of attributes to set on the new conversation. The allowed keys are:
      #              - :name - the name of the conversation.
      #
      # Returns the newly created Conversation object if the record was saved successfully,
      # or error if validation failed.
      class CreateService < ApplicationCallable
        attr_reader :properties

        def initialize(properties)
          @properties = properties
        end

        def call
          conversation = ::Communications::Conversation.create!(name: @properties[:name])

          { success: true, payload: conversation }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
