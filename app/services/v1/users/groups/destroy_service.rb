# frozen_string_literal: true

module V1
  module Users
    module Groups
      # Destroy a group.
      #
      # group - The Group object to destroy
      #
      # Returns the :ok status if the record was destroyed successfully, or error if validation failed.
      class DestroyService < ApplicationCallable
        attr_reader :group

        def initialize(group)
          @group = group
        end

        def call
          @group.destroy!

          { success: true, payload: { done: :ok } }
        end
      end
    end
  end
end
