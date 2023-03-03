# frozen_string_literal: true

module Layout
  class BreadcrumbsComponent < ViewComponent::Base
    delegate :heroicon, to: :helpers

    def initialize(breadcrumbs:)
      super

      @breadcrumbs = breadcrumbs
    end

    def back_link
      if @breadcrumbs.count > 1 && @breadcrumbs.last.link?
        @breadcrumbs.last.path
      else
        authenticated_root_path
      end
    end

    def render?
      @breadcrumbs.count > 1
    end
  end
end
