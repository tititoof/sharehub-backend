# frozen_string_literal: true

# Rack session fix
module RackSessionFix
  extend ActiveSupport::Concern

  # Class faking session
  class FakeRackSession < Hash
    def enabled?
      false
    end
  end

  included do
    before_action :set_fake_rack_session_for_devise

    private

    def set_fake_rack_session_for_devise
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
