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
require 'rails_helper'

RSpec.describe Users::Membership, type: :model do
  describe "Group" do
    subject { FactoryBot.create(:users_membership_group) }

    describe 'attributs' do
      it 'is valid with valid attributes' do
        expect(subject).to be_valid
      end

      it 'is not valid without user' do
        subject.member = nil
    
        expect(subject).not_to be_valid
      end

      it 'is not valid without group' do
        subject.joinable = nil
    
        expect(subject).not_to be_valid
      end
    end

    describe 'associations' do
      it { should belong_to(:member) }
      it { should belong_to(:joinable) }
    end
  end

  describe "Organization" do
    subject { FactoryBot.create(:users_membership_organization) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without user' do
      subject.member = nil
  
      expect(subject).not_to be_valid
    end

    it 'is not valid without organization' do
      subject.joinable = nil
  
      expect(subject).not_to be_valid
    end
  end
end
