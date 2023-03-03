# frozen_string_literal: true

module Layout
  class MenuItemComponent < ViewComponent::Base
    def initialize(name:, path:, active: false, hide: false, mobile: false)
      super

      @active = active
      @name = name
      @path = path
      @hide = hide
      @mobile = mobile
    end

    def link_class
      if @mobile
        "#{base_link_class} #{active_class} block text-base"
      else
        "#{base_link_class} #{active_class} text-sm"
      end
    end

    def render?
      !@hide
    end

    private
      def active_class
        if @active
          'bg-gray-900 text-white'
        else
          'text-gray-300 hover:bg-gray-700 hover:text-white'
        end
      end

      def base_link_class
        'rounded-md px-3 py-2 font-medium'
      end
  end
end
