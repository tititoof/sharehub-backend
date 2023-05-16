# frozen_string_literal: true

# == Schema Information
#
# Table name: users_groups
#
#  id              :uuid             not null, primary key
#  description     :text
#  kind            :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin_id        :uuid             not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_users_groups_on_admin_id         (admin_id)
#  index_users_groups_on_name             (name) UNIQUE
#  index_users_groups_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => users.id)
#  fk_rails_...  (organization_id => organizations.id)
#
module Users
  # This model represents a group of users within an organization.
  # Each group is managed by an admin user, who can add or remove other users from the group.
  # The group belongs to an organization, and can have many users as members.
  class Group < ApplicationRecord
    # ----------------------------------
    # --- Enums ---
    # ----------------------------------
    include GroupKindOptions

    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Admin (user) - belongs to
    belongs_to :admin, class_name: 'User'

    # Organization - belongs to
    belongs_to :organization, class_name: 'Organization'

    # Memberships (Organization - Group)
    has_many :users,
             through: :memberships,
             source: :member,
             source_type: 'User',
             class_name: 'User'

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    validates :description, presence: { message: :required }
    validates :description,
              length: { in: 30..700, too_long: :tooLong,
                        too_short: :tooShort }

    # Kind
    validates :kind, inclusion: { in: kind_options, message: :groupKindInvalid }

    # Name
    validates :name, presence: { message: :required }
    validates :name,
              length: { in: 4..60, too_long: :tooLong,
                        too_short: :tooShort }
    validates :name, uniqueness: { message: :alreadyTaken }
  end
end
