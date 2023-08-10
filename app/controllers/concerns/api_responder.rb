# frozen_string_literal: true

# Render Json response with or without serializer
module ApiResponder
  extend ActiveSupport::Concern

  # render serialized json successes or json errors
  def serializer_response(serializer)
    if @resource[:success]
      render json: serializer.new(@resource[:payload])
    else
      status = @resource[:status] || :precondition_failed

      render json: @resource[:errors], status:
    end
  end

  # render json successes or json errors
  def object_response
    if @resource[:success]
      render json: @resource[:payload], status: :ok
    else
      render json: @resource[:errors], status: :unprocessable_entity
    end
  end
end
