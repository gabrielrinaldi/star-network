# frozen_string_literal: true

module Layout
  class MenuComponent < ViewComponent::Base
    def initialize(user:, mobile: false)
      super

      @user = user
      @mobile = mobile
    end

    def admin_only
      !@user.admin?
    end

    def active(controller)
      Current.controller == controller
    end
  end
end
