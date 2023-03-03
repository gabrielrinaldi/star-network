# frozen_string_literal: true

module Layout
  class ButtonComponent < ViewComponent::Base
    def initialize(text:, path:, data: nil, style: :default)
      super

      @text = text
      @path = path
      @data = data
      @style = style
    end

    def button_class
      "inline-flex items-center rounded-md border border-#{border_color} bg-#{background_color} px-4 py-2 text-sm " \
        "font-medium text-#{text_color} shadow-sm hover:bg-#{hover_background_color} focus:outline-none focus:ring-2 " \
        "focus:ring-#{base_color}-500 focus:ring-offset-2"
    end

    private
      def base_color
        case @style
        when :default
          'indigo'
        when :danger
          'red'
        end
      end

      def text_color
        case @style
        when :default
          'white'
        when :danger
          "#{base_color}-700"
        end
      end

      def border_color
        case @style
        when :default
          'transparent'
        when :danger
          "#{base_color}-300"
        end
      end

      def background_color
        case @style
        when :default
          "#{base_color}-600"
        when :danger
          'white'
        end
      end

      def hover_background_color
        case @style
        when :default
          "#{base_color}-700"
        when :danger
          "#{base_color}-50"
        end
      end
  end
end
