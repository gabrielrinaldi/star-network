# frozen_string_literal: true

module Layout
  class ProfileMenuComponent < ViewComponent::Base
    def initialize(user:, mobile: false)
      super

      @user = user
      @mobile = mobile
    end
  end
end
