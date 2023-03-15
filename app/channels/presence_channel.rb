# frozen_string_literal: true

class PresenceChannel < ApplicationCable::Channel
  def subscribed
    current_user.online!
  end

  def unsubscribed
    current_user.offline!
  end

  def online
    current_user.online!
  end

  def away
    current_user.away! unless current_user.busy?
  end
end
