# frozen_string_literal: true

# == Schema Information
#
# Table name: users_memberships
#
#  id            :uuid             not null, primary key
#  joinable_type :string           not null
#  member_type   :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  joinable_id   :uuid             not null
#  member_id     :uuid             not null
#
# Indexes
#
#  index_users_memberships_on_joinable  (joinable_type,joinable_id)
#  index_users_memberships_on_member    (member_type,member_id)
#
module Users
  # This class represents the membership association between a user
  # and either an organization or a group. It uses a polymorphic association to allow
  # for flexibility in the types of objects that can be associated with memberships.
  # Each membership record also has a role attribute that specifies the user's role within
  # the organization or group, as well as any additional attributes or methods needed to represent
  # the membership relationship.
  class Membership < ApplicationRecord
    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Member - belongs to (User)
    belongs_to :member, polymorphic: true

    # Joinable - belongs to (Organization - Group)
    belongs_to :joinable, polymorphic: true
  end
end
