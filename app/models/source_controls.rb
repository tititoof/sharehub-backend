# frozen_string_literal: true

# This module sets a table name prefix for the Source Controls models. The prefix "source_controls_" will be
# added to all database
# tables associated with the SourceControls model, allowing for better organization and separation of concerns
# in multi-tenant applications or when multiple models are stored in the same database.
module SourceControls
  def self.table_name_prefix
    'source_controls_'
  end
end
