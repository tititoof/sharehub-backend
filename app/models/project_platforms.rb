# frozen_string_literal: true

# This module sets a table name prefix for the ProjectPlatforms model. The prefix "project_platforms_"
# will be added to all database
# tables associated with the ProjectPlatforms model, allowing for better organization and separation of concerns
# in multi-tenant applications or when multiple models are stored in the same database.
module ProjectPlatforms
  def self.table_name_prefix
    'project_platforms_'
  end
end
