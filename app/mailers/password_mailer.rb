class PasswordMailer < ApplicationMailer
  def reset
    @user = params[:user]
    @reset_url = params[:reset_url]

    mail(
      to: @user.email,
      subject: "Reset your LesNoise password"
    )
  end
end
