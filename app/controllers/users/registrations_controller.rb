# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # rubocop:disable Rails/LexicallyScopedActionFilter
    before_action :configure_sign_up_params, only: [:create]
    # rubocop:enable Rails/LexicallyScopedActionFilter
    before_action :configure_account_update_params, only: [:update]

    # @route GET /users/edit (edit_user_registration)
    def edit
      authorize resource
      add_breadcrumb(name: 'Edit User', path: edit_user_registration_path)
    end

    # @route PATCH /users (user_registration)
    # @route PUT /users (user_registration)
    def update
      super do |resource|
        authorize resource
      end
    end

    # @route DELETE /users (user_registration)
    def destroy
      authorize resource

      result = CancelUser.call(user: resource)

      if result.success?
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)

        redirect_to root_path, status: :see_other, notice: 'Account successfuly deleted'
      else
        redirect_to edit_user_registration_path(resource), alert: result.message,
                                                           status: :unprocessable_entity
      end
    end

    protected
      # If you have extra params to permit, append them to the sanitizer.
      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[username])
      end

      # If you have extra params to permit, append them to the sanitizer.
      def configure_account_update_params
        devise_parameter_sanitizer.permit(:account_update, keys: policy(resource).permitted_attributes)
      end
  end
end
