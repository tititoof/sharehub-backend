# frozen_string_literal: true

# The joinable module
module Joinable
  extend ActiveSupport::Concern

  included do
    # Memberships (Organization - Group)
    has_many :memberships, as: :joinable, class_name: '::Users::Membership', dependent: :destroy
  end
end
