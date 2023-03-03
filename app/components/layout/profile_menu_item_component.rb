# frozen_string_literal: true

module Layout
  class ProfileMenuItemComponent < ViewComponent::Base
    def initialize(name:, path:, data: nil, mobile: false)
      super

      @name = name
      @path = path
      @data = data
      @mobile = mobile
    end

    def link_class
      if @mobile
        "#{base_link_class} rounded-md px-3 text-base font-medium text-gray-400 hover:bg-gray-700 hover:text-white"
      else
        "#{base_link_class} px-4 text-sm text-gray-700"
      end
    end

    private
      def base_link_class
        'block py-2'
      end
  end
end
