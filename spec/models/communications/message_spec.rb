# == Schema Information
#
# Table name: communications_messages
#
#  id              :uuid             not null, primary key
#  content         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :uuid             not null
#  user_id         :uuid             not null
#
# Indexes
#
#  index_communications_messages_on_conversation_id  (conversation_id)
#  index_communications_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => communications_conversations.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Communications::Message, type: :model do
  subject { FactoryBot.create(:communications_message) }

  describe 'attributs' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without content' do
      subject.content = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without user' do
      subject.user = nil

      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:conversation).class_name('::Communications::Conversation') }
    it { should have_one_attached(:file) }
  end
end
