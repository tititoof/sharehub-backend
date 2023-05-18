# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id                   :uuid             not null, primary key
#  activity_description :text
#  activity_sector      :string
#  address              :string
#  annual_turnover      :float
#  borned_at            :date
#  email_address        :string
#  kind                 :string
#  legal_status         :string
#  name                 :string
#  number_of_employees  :integer
#  phone_number         :string
#  region               :string
#  registration_number  :string
#  website              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  admin_id             :uuid             not null
#  city_id              :uuid             not null
#  country_id           :uuid             not null
#
# Indexes
#
#  index_organizations_on_admin_id    (admin_id)
#  index_organizations_on_city_id     (city_id)
#  index_organizations_on_country_id  (country_id)
#  index_organizations_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => users.id)
#  fk_rails_...  (city_id => location_cities.id)
#  fk_rails_...  (country_id => location_countries.id)
#
class Organization < ApplicationRecord
  # ----------------------------------
  # --- Enums ---
  # ----------------------------------
  include LegalStatusOptions

  include ActivitySectorOptions

  include KindOptions

  # ----------------------------------
  # --- Relations ---
  # ----------------------------------
  # Admin (user) - belongs to
  belongs_to :admin, class_name: 'User'

  # City - belongs to
  belongs_to :city, class_name: 'Location::City'

  # Country - belongs to
  belongs_to :country, class_name: 'Location::Country'

  # Groups - has many
  has_many :groups, class_name: 'Users::Group', dependent: :destroy

  # Memberships (Organization - Group)
  has_many :memberships, as: :joinable, class_name: '::Users::Membership', dependent: :destroy

  # Memberships users
  has_many :users,
           through: :memberships,
           source: :member,
           source_type: 'User',
           class_name: 'User'

  # ----------------------------------
  # --- Callbacks ---
  # ----------------------------------
  before_save :normalize_phone

  # ----------------------------------
  # --- Validations ---
  # ----------------------------------
  # Activity description
  validates :activity_description, presence: { message: :required }
  validates :activity_description,
            length: { in: 30..700, too_long: :tooLong,
                      too_short: :tooShort }

  # Activity sector
  validates :activity_sector, inclusion: { in: activity_sector_options, message: :activitySectorInvalid }

  # Address
  validates :address, presence: { message: :required }
  validates :address,
            length: { in: 4..100, too_long: :tooLong,
                      too_short: :tooShort }

  # Annual turnover
  validates :annual_turnover, numericality: { only_float: true }

  # Born at
  validates :borned_at, presence: { message: :required }
  validate :born_at_is_date?

  # Email address
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Kind
  validates :kind, inclusion: { in: kind_options, message: :kindInvalid }

  # Legal status
  validates :legal_status, inclusion: { in: legal_status_options, message: :legalStatusInvalid }

  # Name
  validates :name, presence: { message: :required }
  validates :name, uniqueness: { message: :notUnique }
  validates :name,
            length: { in: 4..60, too_long: :tooLong,
                      too_short: :tooShort }

  # Number of employees
  validates :number_of_employees, numericality: { only_integer: true }

  # Phone number
  validates :phone_number, phone: { possible: true, allow_blank: true,
                                    country_specifier: ->(phone) { phone.country.try(:upcase) } }
  validates :phone_number, length: { in: 10..30, too_long: :phoneTooLong,
                                     too_short: :phoneTooShort }

  # Website
  validates :website, url: { allow_nil: true }

  private

  def born_at_is_date?
    return if borned_at.is_a?(Date)

    errors.add(:borned_at, 'dateInvalid')
  end

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
