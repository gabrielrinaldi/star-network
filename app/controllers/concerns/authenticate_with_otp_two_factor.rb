# frozen_string_literal: true

module AuthenticateWithOtpTwoFactor
  extend ActiveSupport::Concern

  def authenticate_with_otp_two_factor
    user = self.resource = find_user

    if user_params[:otp_attempt].present? && session[:otp_user_id]
      authenticate_user_with_otp_two_factor(user)
    elsif user&.valid_password?(user_params[:password])
      prompt_for_otp_two_factor(user)
    end
  end

  private
    def valid_otp_attempt?(user)
      user.validate_and_consume_otp!(user_params[:otp_attempt]) ||
        user.invalidate_otp_backup_code!(user_params[:otp_attempt])
    end

    def prompt_for_otp_two_factor(user)
      @user = user
      session[:otp_user_id] = user.id

      render 'devise/sessions/two_factor', status: :see_other
    end

    def authenticate_user_with_otp_two_factor(user)
      if valid_otp_attempt?(user)
        # Remove any lingering user data from login
        session.delete(:otp_user_id)
        user.save!

        set_flash_message!(:notice, :signed_in)
        sign_in_and_redirect(user, event: :authentication)
      else
        flash.now[:alert] = 'Invalid two-factor code.'
        prompt_for_otp_two_factor(user)
      end
    end

    def user_params
      params.require(:user).permit(:username, :password, :otp_attempt)
    end

    def find_user
      if session[:otp_user_id]
        User.find(session[:otp_user_id])
      elsif user_params[:username]
        User.find_by(username: user_params[:username])
      end
    end

    def otp_two_factor_enabled?
      find_user&.otp_required_for_login
    end
end
