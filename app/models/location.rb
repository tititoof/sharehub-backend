# frozen_string_literal: true

# This module sets a table name prefix for the Location model. The prefix "location_" will be added to all database
# tables associated with the Location model, allowing for better organization and separation of concerns
# in multi-tenant applications or when multiple models are stored in the same database.
module Location
  def self.table_name_prefix
    'location_'
  end
end
