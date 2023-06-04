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
require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { FactoryBot.create(:project) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without category' do
      subject.category = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without description' do
      subject.description = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without end_at' do
      subject.end_at = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without external_references' do
      subject.external_references = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without start_at' do
      subject.start_at = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without status' do
      subject.status = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without title' do
      subject.title = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:manager).class_name('User') }
    it { should belong_to(:organization).class_name('Organization') }
    it { should have_many(:project_members).class_name('ProjectMember') }
    it { should have_many(:members).class_name('User') }
    it { should have_many(:source_control_repositories).class_name('::SourceControls::Repository') }
    it { should have_many(:giteas).class_name('::SourceControls::Gitea') }
  end
end
