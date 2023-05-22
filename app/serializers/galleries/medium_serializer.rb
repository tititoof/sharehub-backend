# frozen_string_literal: true

# == Schema Information
#
# Table name: galleries_media
#
#  id         :uuid             not null, primary key
#  kind       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :uuid             not null
#
# Indexes
#
#  index_galleries_media_on_album_id  (album_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => galleries_albums.id)
#
module Galleries
  # Returns the JSON Medium object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class MediumSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :kind, :album_id
  end
end
