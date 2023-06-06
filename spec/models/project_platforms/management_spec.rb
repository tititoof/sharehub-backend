# == Schema Information
#
# Table name: project_platforms_managements
#
#  id                :uuid             not null, primary key
#  name              :string
#  platformable_type :string           not null
#  project_name      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  platformable_id   :uuid             not null
#  project_id        :uuid             not null
#
# Indexes
#
#  index_project_platforms_managements_on_platformable  (platformable_type,platformable_id)
#  index_project_platforms_managements_on_project_id    (project_id)
#  managements_index_on_project_id_and_project_name     (project_id,project_name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe ProjectPlatforms::Management, type: :model do
  subject { FactoryBot.create(:project_platforms_management) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without project_name' do
      subject.project_name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without project' do
      subject.project = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without platformable' do
      subject.platformable = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:project).class_name('::Project') }
    it { should belong_to(:platformable) }
  end
end
