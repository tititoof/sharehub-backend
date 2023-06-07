# frozen_string_literal: true

module V1
  module Communications
    module Messages
      # Create a message with the specified properties.
      #
      # conversation - the conversation to attach the message
      # properties - A Hash of attributes to set on the new message. The allowed keys are:
      #               - :content - the message's content.
      #               - :medium - the file to attach
      #
      # Returns the newly created Message object if the record was saved successfully,
      # or error if validation failed.
      class CreateService < ApplicationCallable
        attr_reader :conversation, :properties, :current_user

        def initialize(conversation, current_user, properties)
          @conversation = conversation
          @properties   = properties
          @current_user = current_user
        end

        def call
          message = ::Communications::Message.create!(content: @properties[:content],
                                                      user: current_user, conversation: @conversation)

          message.file.attach(@properties[:medium]) if @properties[:medium]

          { success: true, payload: message }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
