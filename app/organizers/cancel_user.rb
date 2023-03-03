# frozen_string_literal: true

class CancelUser
  extend LightService::Organizer

  def self.call(user:)
    with(user:).reduce(actions)
  end

  def self.actions
    [
      DeleteUser,
      NotifyUserDeletion
    ]
  end
end
