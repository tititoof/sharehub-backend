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
require 'rails_helper'

RSpec.describe Users::Group, type: :model do
  subject { FactoryBot.create(:users_group) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without description' do
    subject.description = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid with wrong kind' do
    subject.kind = "wrong enum"

    expect(subject).not_to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

end
