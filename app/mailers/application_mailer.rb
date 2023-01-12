# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'my-blog@example.com'
  layout 'mailer'
end
