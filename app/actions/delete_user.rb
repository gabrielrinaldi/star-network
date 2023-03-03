# frozen_string_literal: true

class DeleteUser
  extend LightService::Action

  expects :user

  executed do |context|
    context.fail_and_return!('Account could not be deleted.') unless context.user.destroy
  end
end
