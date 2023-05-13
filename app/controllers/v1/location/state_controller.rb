# frozen_string_literal: true

module V1
  module Location
    # Manage current_user logged by jwt
    class StateController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!

      # return current_user serialized
      def index
        @resource = V1::Location::SearchStatesService.call(params[:country_id])

        serializer_response(::Location::StateSerializer)
      end
    end
  end
end
