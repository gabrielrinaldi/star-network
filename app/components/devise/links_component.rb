# frozen_string_literal: true

module Devise
  class LinksComponent < ViewComponent::Base
    def initialize(devise_mapping:)
      super

      @devise_mapping = devise_mapping
    end

    def main_app
      Rails.application.class.routes.url_helpers
    end

    def controller
      Current.controller
    end
  end
end
