# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_FROM_ADDRESS', 'noreply@car-maintenance-reminder.onrender.com')
  layout 'mailer'
end