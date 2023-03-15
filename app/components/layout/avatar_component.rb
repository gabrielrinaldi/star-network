# frozen_string_literal: true

module Layout
  class AvatarComponent < ViewComponent::Base
    delegate :thumbnail, to: :helpers
    delegate :turbo_frame_tag, to: :helpers

    PRESENCE_COLORS = {
      offline: 'bg-grey-400',
      online: 'bg-green-400',
      busy: 'bg-red-400',
      away: 'bg-yellow-400'
    }.freeze

    def initialize(user:)
      super

      @user = user
    end

    def presence_color
      PRESENCE_COLORS[@user.presence.to_sym]
    end
  end
end
