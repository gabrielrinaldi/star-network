# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!, :update_current, :check_if_verified
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :breadcrumbs

  add_flash_types :info

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def breadcrumbs
    @breadcrumbs ||= []
  end

  protected
    def add_breadcrumb(name:, path: nil)
      breadcrumbs << Breadcrumb.new(name:, path:)
    end

    def update_current
      Current.user = current_user
      Current.controller = controller_name
    end

    def check_if_verified
      flash[:alert] = 'User has not been verified yet' if current_user && current_user.verified_at.nil?
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email otp_attempt])
    end

  private
    def user_not_authorized
      redirect_back fallback_location: authenticated_root_path, status: :see_other,
                    alert: 'User not authorized'
    end
end
