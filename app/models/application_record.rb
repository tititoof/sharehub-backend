# frozen_string_literal: true

# The base class for all models in the application. It inherits from `ActiveRecord::Base`,
# and includes the `primary_abstract_class` macro which marks the class as an abstract base class.
# This class should not be instantiated directly, but instead should be subclassed to create concrete
# models with database tables. This class provides the default database connection, and includes
# a number of built-in methods for querying and manipulating data in the database.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
