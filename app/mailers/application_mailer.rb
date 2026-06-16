class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "LesNoise Support <support@lesnoise.com>")
  layout "mailer"
end
