# frozen_string_literal: true

# The GroupKindOptions enums
module GroupKindOptions
  extend ActiveSupport::Concern

  included do
    enum kind_options: {
      organization: :organization,
      user: :user
    }
  end
end
