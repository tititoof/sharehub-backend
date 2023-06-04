# frozen_string_literal: true

# == Schema Information
#
# Table name: source_controls_repositories
#
#  id             :uuid             not null, primary key
#  name           :string
#  owner          :string
#  repo           :string
#  sourcable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  project_id     :uuid             not null
#  sourcable_id   :uuid             not null
#
# Indexes
#
#  index_source_controls_repositories_on_project_id           (project_id)
#  index_source_controls_repositories_on_project_id_and_name  (project_id,name) UNIQUE
#  index_source_controls_repositories_on_sourcable            (sourcable_type,sourcable_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
module SourceControls
  # Repository is an ActiveRecord model representing a Repository server.
  class Repository < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Project - belongs to
    belongs_to :project, class_name: '::Project'

    # Sourcable - belongs to (Gitea / Gitlab / Github / ...)
    belongs_to :sourcable, polymorphic: true

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Name
    validates :name, presence: { message: :required }
    validates :name, uniqueness: { scope: :project_id, message: :notUnique }
    validates :name,
              length: { in: 4..60, too_long: :tooLong,
                        too_short: :tooShort }
    # Owner
    validates :owner, presence: { message: :required }

    # Repo
    validates :repo, presence: { message: :required }
  end
end
