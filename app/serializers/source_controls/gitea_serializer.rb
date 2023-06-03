# frozen_string_literal: true

# == Schema Information
#
# Table name: source_controls_giteas
#
#  id           :uuid             not null, primary key
#  access_token :string
#  api_url      :string
#  ip_address   :string
#  port         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
module SourceControls
  # Returns the JSON Gitea object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class GiteaSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :access_token, :api_url, :ip_address, :port
  end
end
