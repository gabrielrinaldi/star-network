# frozen_string_literal: true

module Shared
  class FlashComponent < ViewComponent::Base
    def initialize(flash:)
      super

      @flash = flash
    end
  end
end
