# == Schema Information
#
# Table name: communications_conversations
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Communications::Conversation, type: :model do
  subject { FactoryBot.create(:communications_conversation) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:messages).class_name('::Communications::Message') }
    it { should have_many(:groups).class_name('::Users::Group') }
    it { should have_many(:users).class_name('::User') }
    it { should have_many(:admins).class_name('::User') }
  end
end
