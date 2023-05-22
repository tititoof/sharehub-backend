# frozen_string_literal: true

# == Schema Information
#
# Table name: galleries_albums
#
#  id             :uuid             not null, primary key
#  aasm_state     :string
#  albumable_type :string           not null
#  description    :text
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  albumable_id   :uuid             not null
#
# Indexes
#
#  index_galleries_albums_on_albumable  (albumable_type,albumable_id)
#
module Galleries
  # Returns the JSON Album object.
  #
  # set_key_transform :camel_lower - "some_key" => "someKey"
  class AlbumSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower

    attributes :id, :aasm_state, :title, :description
  end
end
