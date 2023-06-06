# == Schema Information
#
# Table name: source_controls_repositories
#
#  id             :uuid             not null, primary key
#  name           :string
#  owner          :string
#  repo           :string
#  sourcable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  project_id     :uuid             not null
#  sourcable_id   :uuid             not null
#
# Indexes
#
#  index_source_controls_repositories_on_project_id           (project_id)
#  index_source_controls_repositories_on_project_id_and_name  (project_id,name) UNIQUE
#  index_source_controls_repositories_on_sourcable            (sourcable_type,sourcable_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe SourceControls::Repository, type: :model do
  subject { FactoryBot.create(:source_controls_repository) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without owner' do
      subject.owner = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without repo' do
      subject.repo = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:project).class_name('::Project') }
    it { should belong_to(:sourcable) }
  end
end
