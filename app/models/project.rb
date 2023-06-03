# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id                  :uuid             not null, primary key
#  category            :string
#  description         :text
#  end_at              :date
#  external_references :string
#  start_at            :date
#  status              :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  manager_id          :uuid             not null
#  organization_id     :uuid             not null
#
# Indexes
#
#  index_projects_on_manager_id                 (manager_id)
#  index_projects_on_organization_id            (organization_id)
#  index_projects_on_organization_id_and_title  (organization_id,title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (manager_id => users.id)
#  fk_rails_...  (organization_id => organizations.id)
#
class Project < ApplicationRecord
  # ----------------------------------
  # --- Enums ---
  # ----------------------------------
  include ProjectCategoryOptions

  include ProjectStatusOptions

  # ----------------------------------
  # --- Relations ---
  # ----------------------------------
  # Manager (user) - belongs to
  belongs_to :manager, class_name: 'User'

  # Organization - belongs to
  belongs_to :organization

  # Project Members
  has_many :project_members, dependent: :destroy

  # Members (Users)
  has_many :members, through: :project_members, dependent: :destroy

  # Respositories
  has_many :source_control_repositories, class_name: '::SourceControls::Repository', dependent: :destroy

  # Giteas
  has_many :giteas, through: :source_control_repositories, source: :sourcable, source_type: '::SourceControls::Gitea'

  # ----------------------------------
  # --- Validations ---
  # ----------------------------------
  # Category
  validates :category, inclusion: { in: project_category_options, message: :categoryInvalid }

  # Description
  validates :description, presence: { message: :required }
  validates :description,
            length: { in: 30..700, too_long: :tooLong,
                      too_short: :tooShort }

  # End_at
  validates :end_at, presence: true

  # External references
  validates :external_references, presence: { message: :required }
  validates :external_references,
            length: { in: 4..120, too_long: :tooLong,
                      too_short: :tooShort }

  # Start_at
  validates :start_at, presence: true
  validate :start_at_before_end_at

  # status
  validates :status, inclusion: { in: project_status_options, message: :statusInvalid }

  # Title
  validates :title, presence: { message: :required }
  validates :title, uniqueness: { scope: :organization_id, message: :notUnique }
  validates :title,
            length: { in: 4..60, too_long: :tooLong,
                      too_short: :tooShort }

  private

  def start_at_before_end_at
    return unless start_at && end_at && start_at >= end_at

    errors.add(:start_at, :startAtMustBeforeEndAt)
  end
end
