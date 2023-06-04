# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  is_admin               :boolean          default(FALSE)
#  jti                    :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  # ----------------------------------
  # --- Relations ---
  # ----------------------------------
  # Profile - has one - destroy profile on destroy user
  has_one :profile, class_name: 'Users::Profile', dependent: :destroy

  # Memberships (Organization - Group)
  has_many :memberships, as: :member, class_name: '::Users::Membership', dependent: :destroy

  # Group - has_many
  has_many :groups,
           through: :memberships,
           source: :joinable,
           source_type: 'Users::Group',
           class_name: 'Users::Group'

  # Organization - has_many
  has_many :organizations,
           through: :memberships,
           source: :joinable,
           source_type: 'Organization',
           class_name: 'Organization'

  # Albums
  include Albumable

  # Conversations
  include Conversationable
end
