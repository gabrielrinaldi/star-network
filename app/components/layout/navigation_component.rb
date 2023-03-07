# frozen_string_literal: true

module Layout
  class NavigationComponent < ViewComponent::Base
    delegate :thumbnail, to: :helpers

    def initialize(title:, current_user:, breadcrumbs:)
      super

      @title = title
      @current_user = current_user
      @breadcrumbs = breadcrumbs
    end
  end
end
