# frozen_string_literal: true

# == Schema Information
#
# Table name: source_controls_giteas
#
#  id           :uuid             not null, primary key
#  access_token :string
#  api_url      :string
#  ip_address   :string
#  port         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
module SourceControls
  # Gitea is an ActiveRecord model representing a Gitea server.
  class Gitea < ApplicationRecord
    # ----------------------------------
    # --- Constants ---
    # ----------------------------------
    IP_ADDRESS_REGEX = /^((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})$/

    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Sourcable - Repositories
    include Sourcable

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Access token
    validates :access_token, presence: true

    # Api url
    validates :api_url, presence: true

    # Ip address
    validates :ip_address, presence: true
    validate :ip_address_is_valid?

    # Port
    validates :port, numericality: { only_integer: true }

    private

    def ip_address_is_valid?
      return if ip_address =~ IP_ADDRESS_REGEX

      errors.add(:ip_address, 'ipAddressInvalid')
    end
  end
end
