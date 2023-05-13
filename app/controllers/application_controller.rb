# frozen_string_literal: true

class ApplicationController < ActionController::API
  # Json responses
  include ApiResponder

  respond_to :json
end
