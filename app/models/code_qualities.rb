# frozen_string_literal: true

# This module sets a table name prefix for the CodeQualities model. The prefix "code_qualities_"
# will be added to all database
# tables associated with the CodeQualities model, allowing for better organization and separation of concerns
# in multi-tenant applications or when multiple models are stored in the same database.
module CodeQualities
  def self.table_name_prefix
    'code_qualities_'
  end
end
