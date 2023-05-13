# frozen_string_literal: true

module V1
  module Location
    # Manage current_user logged by jwt
    class CityController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!

      # return current_user serialized
      def index
        @resource = V1::Location::SearchCitiesService.call(params[:state_id])

        serializer_response(::Location::CitySerializer)
      end
    end
  end
end
