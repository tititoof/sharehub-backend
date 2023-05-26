# frozen_string_literal: true

# This module sets a table name prefix for the Commnunications model. The prefix "communication_" 
# will be added to all database
# tables associated with the User model, allowing for better organization and separation of concerns
# in multi-tenant applications or when multiple models are stored in the same database.
module Communications
  def self.table_name_prefix
    'communications_'
  end
end
