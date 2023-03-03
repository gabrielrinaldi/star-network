# frozen_string_literal: true

class TwoFactorSettingsController < ApplicationController
  before_action :add_two_factor_breadcrumb

  # @route GET /two_factor_settings/new (new_two_factor_settings)
  def new
    add_breadcrumb(name: 'Two Factor', path: new_two_factor_settings_path)

    if current_user.otp_required_for_login
      return redirect_to edit_user_registration_path, alert: 'Two Factor Authentication is already enabled.'
    end

    current_user.generate_two_factor_secret_if_missing!
  end

  # @route GET /two_factor_settings/edit (edit_two_factor_settings)
  def edit
    add_breadcrumb(name: 'Two Factor', path: edit_two_factor_settings_path)

    unless current_user.otp_required_for_login
      return redirect_to new_two_factor_settings_path, alert: 'Please enable two factor authentication first.'
    end

    if current_user.two_factor_backup_codes_generated?
      return redirect_to edit_user_registration_path, alert: 'You have already seen your backup codes.'
    end

    @backup_codes = current_user.generate_otp_backup_codes!
    current_user.save!
  end

  # @route POST /two_factor_settings (two_factor_settings)
  def create
    add_breadcrumb(name: 'Two Factor', path: new_two_factor_settings_path)

    return render :new, alert: 'Incorrect password' unless current_user.valid_password?(enable_2fa_params[:password])

    if current_user.validate_and_consume_otp!(enable_2fa_params[:code])
      current_user.enable_two_factor!

      redirect_to edit_two_factor_settings_path,
                  notice: 'Successfully enabled two factor authentication, please make note of your backup codes.'
    else
      render :new, alert: 'Incorrect Code'
    end
  end

  # @route DELETE /two_factor_settings (two_factor_settings)
  def destroy
    add_breadcrumb(name: 'Two Factor', path: edit_two_factor_settings_path)

    if current_user.disable_two_factor!
      redirect_to edit_user_registration_path, notice: 'Successfully disabled two factor authentication.'
    else
      redirect_back fallback_location: root_path, alert: 'Could not disable two factor authentication.'
    end
  end

  private
    def enable_2fa_params
      params.require(:two_fa).permit(:code, :password)
    end

    def add_two_factor_breadcrumb
      add_breadcrumb(name: 'User', path: edit_user_registration_path)
    end
end
