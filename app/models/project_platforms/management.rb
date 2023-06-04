# frozen_string_literal: true

# == Schema Information
#
# Table name: project_platforms_managements
#
#  id                :uuid             not null, primary key
#  name              :string
#  platformable_type :string           not null
#  project_name      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  platformable_id   :uuid             not null
#  project_id        :uuid             not null
#
# Indexes
#
#  index_project_platforms_managements_on_platformable  (platformable_type,platformable_id)
#  index_project_platforms_managements_on_project_id    (project_id)
#  managements_index_on_project_id_and_project_name     (project_id,project_name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
module ProjectPlatforms
  # Management is an ActiveRecord model representing a link between Project and ProjectPlatforms server
  # (Openproject / Refmine / ...).
  class Management < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Project - belongs to
    belongs_to :project

    # Platformable - belongs to (Openproject / Redmine)
    belongs_to :platformable, polymorphic: true

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Name
    validates :name, presence: { message: :required }
    validates :name,
              length: { in: 4..60, too_long: :tooLong,
                        too_short: :tooShort }

    # Project name
    validates :project_name, presence: { message: :required }
    validates :project_name, uniqueness: { scope: :project_id, message: :notUnique }
  end
end
