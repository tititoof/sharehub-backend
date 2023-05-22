# frozen_string_literal: true

# This module sets a table name prefix for the Galleries model. The prefix "galleries_" will be added to all database
# tables associated with the Galleries model, allowing for better organization and separation of concerns
# in multi-tenant applications or when multiple models are stored in the same database.
module Galleries
  def self.table_name_prefix
    'galleries_'
  end
end
