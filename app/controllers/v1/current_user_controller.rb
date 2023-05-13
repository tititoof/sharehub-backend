# frozen_string_literal: true

module V1
  # Manage current_user logged by jwt
  class CurrentUserController < ApplicationController
    # force current_user to be authenticate
    before_action :authenticate_user!

    # return current_user serialized
    def index
      @resource = { success: true, payload: current_user }

      serializer_response(UserSerializer)
    end
  end
end
