# frozen_string_literal: true

module ThumbnailHelper
  def thumbnail(user:)
    (user.thumbnail.presence || 'https://cdn.robertsspaceindustries.com/static/images/account/avatar_default_big.jpg')
  end
end
