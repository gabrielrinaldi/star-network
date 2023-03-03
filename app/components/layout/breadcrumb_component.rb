# frozen_string_literal: true

module Layout
  class BreadcrumbComponent < ViewComponent::Base
    delegate :heroicon, to: :helpers

    def initialize(breadcrumb:)
      super

      @breadcrumb = breadcrumb
    end
  end
end
