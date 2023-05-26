# == Schema Information
#
# Table name: communications_conversations
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :communications_conversation, class: 'Communications::Conversation' do
    name { Faker::Music::RockBand.song }
  end
end
