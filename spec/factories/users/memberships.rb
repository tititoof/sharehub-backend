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
FactoryBot.define do
  factory :users_membership, class: 'Users::Membership' do
    factory :users_membership_group, class: 'Users::Membership' do
      member { FactoryBot.create(:user) }
      joinable { FactoryBot.create(:users_group) }
    end

    factory :users_membership_organization, class: 'Users::Membership' do
      member { FactoryBot.create(:user) }
      joinable { FactoryBot.create(:organization) }
    end
  end
end
