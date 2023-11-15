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
  # Medium is an ActiveRecord model representing an Medium.
  class Medium < ApplicationRecord
    # ----------------------------------
    # --- Enum ---
    # ----------------------------------
    attribute :kind, :string
    enum kind: {
      image: 'image',
      viedo: 'viedo'
    }

    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Album - belongs to
    belongs_to :album, class_name: '::Galleries::Album'

    # File - has one (ActiveStorage)
    has_one_attached :file

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Kind
    # validates :kind, inclusion: { in: kind_options, message: :kindInvalid }
  end
end
