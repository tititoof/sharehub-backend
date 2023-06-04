# == Schema Information
#
# Table name: project_members
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :uuid             not null
#  project_id :uuid             not null
#
# Indexes
#
#  index_project_members_on_member_id   (member_id)
#  index_project_members_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => users.id)
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe ProjectMember, type: :model do
  subject { FactoryBot.create(:project_member) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without member' do
      subject.member = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without project' do
      subject.project = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:member).class_name('User') }
    it { should belong_to(:project).class_name('Project') }
  end
end
