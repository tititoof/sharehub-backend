# frozen_string_literal: true

# The GroupKindOptions enums
module GroupKindOptions
  extend ActiveSupport::Concern

  included do
    attribute :kind, :string
    enum :kind, {
      organization: 'organization',
      user: 'user'
    }, validate: true
  end
end
