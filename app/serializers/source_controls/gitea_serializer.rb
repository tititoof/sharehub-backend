# frozen_string_literal: true

# == Schema Information
#
# Table name: source_controls_giteas
#
#  id              :uuid             not null, primary key
#  access_token    :string
#  api_url         :string
#  ip_address      :string
#  name            :string
#  port            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :uuid             not null
#
# Indexes
#
#  index_source_controls_giteas_on_organization_id           (organization_id)
#  index_source_controls_giteas_on_organization_id_and_name  (organization_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
module SourceControls
  # Returns the JSON Gitea object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class GiteaSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :access_token, :api_url, :ip_address, :port, :name
  end
end
