# frozen_string_literal: true

# == Schema Information
#
# Table name: project_platforms_openprojects
#
#  id              :uuid             not null, primary key
#  access_token    :string
#  api_url         :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_project_platforms_openprojects_on_organization_id  (organization_id)
#  openprojects_index_on_organization_id_and_name           (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
module ProjectPlatforms
  # Openproject is an ActiveRecord model representing a Openproject server.
  class Openproject < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Organization - belongs to
    belongs_to :organization

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Access token
    validates :access_token, presence: true

    # Api url
    validates :api_url, presence: true

    # Name
    validates :name, presence: { message: :required }
    validates :name, uniqueness: { scope: :organization_id, message: :notUnique }
    validates :name,
              length: { in: 4..60, too_long: :tooLong,
                        too_short: :tooShort }
  end
end
