# frozen_string_literal: true

# The ApplicationCallable class provides a generic interface for calling objects with parameters.
# It defines a `call` method that can be overridden in subclasses to perform the necessary logic.
# The `self.call(...)` method is provided as a convenience method for instantiating the object
# and calling the `call` method in a single step.
# This pattern allows for easy reuse of code across different parts of the application.
class ApplicationCallable
  def self.call(...)
    new(...).call
  end
end
