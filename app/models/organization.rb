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
#  city_id              :uuid             not null
#  country_id           :uuid             not null
#
# Indexes
#
#  index_organizations_on_city_id     (city_id)
#  index_organizations_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => location_cities.id)
#  fk_rails_...  (country_id => location_countries.id)
#
class Organization < ApplicationRecord
  # --- Enums ---
  enum legal_status_options: {
    entreprise: :entreprise,
    association_status: :association_status,
    cooperative_status: :cooperative_status,
    ngo: :ngo,
    union: :union,
    foundation: :foundation,
    other_status: :other_status
  }

  enum activity_sector_options: { agriculture_forestry: :agriculture_forestry, # Agriculture and forestry
                                  energy_utilities: :energy_utilities, # Energy and utilities
                                  finance_insurance: :finance_insurance, # Finance and insurance
                                  government_public_sector: :government_public_sector, # Government and public sector
                                  healthcare_pharmaceuticals: :healthcare_pharmaceuticals, # Healthcare and pharmaceuticals
                                  it_telecommunications: :it_telecommunications, # IT and telecommunications
                                  manufacturing_engineering: :manufacturing_engineering, # Manufacturing and engineering
                                  media_entertainment: :media_entertainment, # Media and entertainment
                                  nonprofit_charity: :nonprofit_charity, # Nonprofit and charity
                                  real_estate_construction: :real_estate_construction, # Real estate and construction
                                  retail_consumer_goods: :retail_consumer_goods, # Retail and consumer goods
                                  transportation_logistics: :transportation_logistics, # Transportation and logistics
                                  travel_hospitality: :travel_hospitality, # Travel and hospitality
                                  other_activity: :other_activity } # Other

  enum kind_options: {
    sole_trader: :sole_trader, # Entreprise individuelle
    single_member_llc: :single_member_llc, # Entreprise unipersonnelle à responsabilité limitée (EURL)
    llc: :llc, # Société à responsabilité limitée (SARL)
    sa: :sa, # Société anonyme (SA)
    general_partnership: :general_partnership, # Société en nom collectif (SNC)
    limited_partnership: :limited_partnership, # Société en commandite simple (SCS)
    partnership_limited_by_shares: :partnership_limited_by_shares, # Société en commandite par actions (SCA)
    association: :association, # Association
    cooperative: :cooperative, # Coopérative
    non_profit_organization: :non_profit_organization, # Organisme sans but lucratif (OSBL)
    public_administration: :public_administration, # Administration publique
    other_kind: :other_kind
  }

  # --- Relations ---
  # Country - belongs to
  belongs_to :country, class_name: 'Location::Country'
  # City - belongs to
  belongs_to :city, class_name: 'Location::City'

  # --- Callbacks ---
  before_save :normalize_phone

  # --- Validations ---
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
            length: { in: 8..100, too_long: :tooLong,
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
  validates :name,
            length: { in: 8..60, too_long: :tooLong,
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
