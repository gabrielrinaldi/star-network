# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include AuthenticateWithOtpTwoFactor

    prepend_before_action :authenticate_with_otp_two_factor,
                          if: -> { action_name == 'create' && otp_two_factor_enabled? }
  end
end
