# == Schema Information
#
# Table name: communications_participants
#
#  id              :uuid             not null, primary key
#  member_type     :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :uuid             not null
#  member_id       :uuid             not null
#
# Indexes
#
#  index_communications_participants_on_conversation_id  (conversation_id)
#  index_communications_participants_on_member           (member_type,member_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => communications_conversations.id)
#
require 'rails_helper'

RSpec.describe Communications::Participant, type: :model do
  subject { FactoryBot.create(:communications_participant) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without member' do
      subject.member = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without conversation' do
      subject.conversation = nil

      expect(subject).not_to be_valid
    end

    subject { FactoryBot.create(:communications_participant_group) }
    
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without member' do
      subject.member = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without conversation' do
      subject.conversation = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:conversation).class_name('::Communications::Conversation') }
    it { should belong_to(:member) }
  end
end
