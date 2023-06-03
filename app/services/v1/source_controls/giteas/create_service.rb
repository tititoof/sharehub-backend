# frozen_string_literal: true

module V1
  module SourceControls
    module Giteas
      # Create a gitea server with the specified properties.
      #
      # properties - A Hash of attributes to set on the new gitea. The allowed keys are:
      #             - access_token - the access token to connect to the server
      #             - api_url - the api_url
      #             - ip_address - the ip address
      #             - port - the port
      #
      # Returns the newly created Gitea object if the record was saved successfully,
      # or error if validation failed.
      class CreateService < ApplicationCallable
        attr_reader :properties

        def initialize(properties)
          @properties = properties
        end

        def call
          gitea = ::SourceControls::Gitea.create!(access_token: @properties[:access_token],
                                                  api_url: @properties[:api_url],
                                                  ip_address: @properties[:ip_address], port: @properties[:port])

          { success: true, payload: gitea }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
