# frozen_string_literal: true

# == Schema Information
#
# Table name: source_controls_giteas
#
#  id              :uuid             not null, primary key
#  access_token    :string
#  api_url         :string
#  ip_address      :string
#  name            :string
#  port            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_source_controls_giteas_on_organization_id           (organization_id)
#  index_source_controls_giteas_on_organization_id_and_name  (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
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

    # Organization - belongs to
    belongs_to :organization

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

    # Name
    validates :name, presence: { message: :required }
    validates :name, uniqueness: { scope: :organization_id, message: :notUnique }
    validates :name,
              length: { in: 4..60, too_long: :tooLong,
                        too_short: :tooShort }

    private

    def ip_address_is_valid?
      return if ip_address =~ IP_ADDRESS_REGEX

      errors.add(:ip_address, 'ipAddressInvalid')
    end
  end
end
