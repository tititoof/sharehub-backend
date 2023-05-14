# frozen_string_literal: true

# == Schema Information
#
# Table name: users_profiles
#
#  id            :uuid             not null, primary key
#  address       :string
#  date_of_birth :date
#  email         :string
#  first_name    :string
#  last_name     :string
#  nickname      :string
#  phone         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  city_id       :uuid
#  user_id       :uuid             not null
#
# Indexes
#
#  index_users_profiles_on_city_id   (city_id)
#  index_users_profiles_on_nickname  (nickname) UNIQUE
#  index_users_profiles_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => location_cities.id)
#  fk_rails_...  (user_id => users.id)
#
module Users
  # Profile model representing a user profile
  class Profile < ApplicationRecord
    # --- Relations ---
    # City - belongs to
    belongs_to :city, class_name: 'Location::City'
    # User - belongs to
    belongs_to :user,  class_name: 'User'

    # --- Callbacks ---
    before_save :normalize_phone

    # --- Validations ---
    # Date of birth
    validate :validate_age

    # First name
    validates :first_name, presence: { message: :required }
    validates :first_name,
              length: { in: 4..30, too_long: :tooLong,
                        too_short: :tooShort }

    # Last name
    validates :last_name, presence: { message: :required }
    validates :last_name,
              length: { in: 4..30, too_long: :tooLong,
                        too_short: :tooShort }

    # Nickname
    validates :nickname, presence: { message: :required }
    validates :nickname,
              length: { in: 3..30, too_long: :nicknameTooLong,
                        too_short: :nicknameTooShort }
    validates :nickname, uniqueness: { case_sensitive: false, message: :notUnique }

    # Phone
    validates :phone, phone: { possible: true, allow_blank: true }
    validates :phone, length: { in: 10..30, too_long: :phoneTooLong,
                                too_short: :phoneTooShort }

    private

    # Validate user's age
    def validate_age
      return unless date_of_birth.present? && date_of_birth.after?(18.years.ago)

      errors.add(:date_of_birth, 'dateOfBirthOver18')
    end

    def normalize_phone
      self.phone = Phonelib.parse(phone).full_e164.presence
    end
  end
end
