# frozen_string_literal: true

# The base mailer for the application.
# All mailers should inherit from this mailer.
class ApplicationMailer < ActionMailer::Base
  # Set the default 'from' email address
  default from: 'from@example.com'

  # Use the 'mailer' layout for all emails
  layout 'mailer'
end
