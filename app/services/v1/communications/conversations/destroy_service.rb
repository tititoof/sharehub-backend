# frozen_string_literal: true

module V1
  module Communications
    module Conversations
      # Destroy a conversation.
      #
      # conversation - The conversation to destroy
      #
      # Returns an object with done : ok if the record was destroy successfully,
      # or error if not found.
      class DestroyService < ApplicationCallable
        attr_reader :conversation

        def initialize(conversation)
          @conversation = conversation
        end

        def call
          @conversation.destroy!

          { success: true, payload: { done: :ok } }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
