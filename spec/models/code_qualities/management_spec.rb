# == Schema Information
#
# Table name: code_qualities_managements
#
#  id              :uuid             not null, primary key
#  name            :string
#  project_name    :string
#  qualitable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :uuid             not null
#  qualitable_id   :uuid             not null
#
# Indexes
#
#  cq_managements_index_on_project_id_and_project_name  (project_id,project_name) UNIQUE
#  index_code_qualities_managements_on_project_id       (project_id)
#  index_code_qualities_managements_on_qualitable       (qualitable_type,qualitable_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe CodeQualities::Management, type: :model do
  subject { FactoryBot.create(:code_qualities_management) }

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

    it 'is not valid without qualitable' do
      subject.qualitable = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:project).class_name('::Project') }
    it { should belong_to(:qualitable) }
  end
end
