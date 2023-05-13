# frozen_string_literal: true

# This module sets a table name prefix for the User model. The prefix "users_" will be added to all database
# tables associated with the User model, allowing for better organization and separation of concerns
# in multi-tenant applications or when multiple models are stored in the same database.
module Users
  def self.table_name_prefix
    'users_'
  end
end
