# frozen_string_literal: true

module Devise
  class HeaderComponent < ViewComponent::Base
    def initialize(title:, link_title:, link_path:)
      super

      @title = title
      @link_title = link_title
      @link_path = link_path
    end
  end
end
