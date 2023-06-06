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
FactoryBot.define do
  factory :communications_message, class: 'Communications::Message' do
    conversation { FactoryBot.create(:communications_conversation) }
    content { Faker::Lorem.sentence(word_count: 5) }
    user { FactoryBot.create(:user) }
  end
end
