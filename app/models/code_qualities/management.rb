# frozen_string_literal: true

# == Schema Information
#
# Table name: code_qualities_managements
#
#  id              :uuid             not null, primary key
#  name            :string
#  project_name    :string
#  qualitable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :uuid             not null
#  qualitable_id   :uuid             not null
#
# Indexes
#
#  cq_managements_index_on_project_id_and_project_name  (project_id,project_name) UNIQUE
#  index_code_qualities_managements_on_project_id       (project_id)
#  index_code_qualities_managements_on_qualitable       (qualitable_type,qualitable_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
module CodeQualities
  # Management is an ActiveRecord model representing a link between Project and CodeQuality server
  # (Sonarqube / ...).
  class Management < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Project - belongs to
    belongs_to :project

    # Platformable - belongs to (Sonarqube / ...)
    belongs_to :qualitable, polymorphic: true

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
