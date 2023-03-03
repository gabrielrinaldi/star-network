# frozen_string_literal: true

module Devise
  class FrameComponent < ViewComponent::Base
    def initialize(devise_mapping:, flash:)
      super

      @devise_mapping = devise_mapping
      @flash = flash
    end
  end
end
