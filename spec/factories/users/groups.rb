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
FactoryBot.define do
  factory :users_group, class: 'Users::Group' do
    name { Faker::FunnyName.name }
    description { Faker::Books::Lovecraft.paragraph }
    kind { Users::Group::kind_options.keys.sample }
    admin { FactoryBot.create(:user) }
    organization { FactoryBot.create(:organization) }
  end
end
