# frozen_string_literal: true

module Shared
  class FlashNotificationComponent < ViewComponent::Base
    def initialize(type:)
      super

      @type = type
    end

    def bg_color
      case @type
      when 'info'
        'bg-blue-50'
      when 'alert'
        'bg-yellow-50'
      when 'notice'
        'bg-green-50'
      else
        'bg-red-50'
      end
    end

    def border_color
      case @type
      when 'info'
        'border-blue-400'
      when 'alert'
        'border-yellow-400'
      when 'notice'
        'border-green-400'
      else
        'border-red-400'
      end
    end

    def icon_color
      case @type
      when 'info'
        'text-blue-400'
      when 'alert'
        'text-yellow-400'
      when 'notice'
        'text-green-400'
      else
        'text-red-400'
      end
    end

    def text_color
      case @type
      when 'info'
        'text-blue-700'
      when 'alert'
        'text-yellow-700'
      when 'notice'
        'text-green-700'
      else
        'text-red-700'
      end
    end

    def icon
      case @type
      when 'info'
        'information-circle'
      when 'alert'
        'exclamation-triangle'
      when 'notice'
        'check-circle'
      else
        'x-circle'
      end
    end

    def render?
      @type != 'timedout'
    end
  end
end
