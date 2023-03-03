# frozen_string_literal: true

class NotifyUserDeletion
  extend LightService::Action

  expects :user

  executed do |context|
    UserMailer.with(user: context.user).delete.deliver_later if context.user.email.present?
  end
end
