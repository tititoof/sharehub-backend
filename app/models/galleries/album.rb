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
  # Album is an ActiveRecord model representing an Album.
  class Album < ApplicationRecord
    # AASM
    include AASM

    # ----------------------------------
    # --- Relations ---
    # ----------------------------------
    # Albumable - belongs to (User | Group | Organization)
    belongs_to :albumable, polymorphic: true

    # Media - has many media
    has_many :media, class_name: '::Galleries::Medium', dependent: :destroy

    # ----------------------------------
    # --- Validations ---
    # ----------------------------------
    # Description
    validates :description, presence: { message: :required }
    validates :description,
              length: { in: 30..700, too_long: :tooLong,
                        too_short: :tooShort }
    # Title
    validates :title, presence: { message: :required }
    validates :title,
              length: { in: 4..60, too_long: :tooLong,
                        too_short: :tooShort }

    # ----------------------------------
    # --- State ---
    # ----------------------------------
    aasm column: 'aasm_state' do
      state :draft, initial: true
      state :private_published
      state :friend_published
      state :public_published

      event :private_publish do
        transitions from: %i[draft public_published friend_published], to: :private_published
      end

      event :friend_publish do
        transitions from: %i[draft private_published public_published], to: :friend_published
      end

      event :public_publish do
        transitions from: %i[draft private_published friend_published], to: :public_published
      end

      event :draft_publish do
        transitions from: %i[public_published private_published friend_published], to: :draft
      end
    end
  end
end
