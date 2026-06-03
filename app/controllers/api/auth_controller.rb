module Api
  class AuthController < ApplicationController
    skip_before_action :authorize_request, only: [:signup, :login, :forgot_password, :reset_password]

    def signup
      user = User.new(user_params)

      if user.save
        token = encode_token({ user_id: user.id })
        render json: { user: user, token: token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def login
      user = User.find_by(email: params[:email])

      if user&.authenticate(params[:password])
        token = encode_token({ user_id: user.id })
        render json: { user: user, token: token }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end

    def forgot_password
      user = User.find_by(email: params[:email])

      if user
        user.generate_password_reset_token!

        reset_url = "#{params[:frontend_url]}/reset-password/#{user.reset_password_token}"

        PasswordMailer.with(user: user, reset_url: reset_url).reset.deliver_now
      end

      render json: {
        message: "If that email exists, password reset instructions have been sent."
      }, status: :ok
    end

    def reset_password
      user = User.find_by(reset_password_token: params[:token])

      unless user&.password_reset_token_valid?
        return render json: { error: "Password reset link is invalid or expired." }, status: :unprocessable_entity
      end

      if user.update(
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
        user.clear_password_reset_token!
        render json: { message: "Password has been reset successfully." }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end