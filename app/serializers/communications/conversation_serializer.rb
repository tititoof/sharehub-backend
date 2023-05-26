# == Schema Information
#
# Table name: communications_conversations
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Communications
  # Returns the JSON Conversation object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class ConversationSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :name
  end
end
