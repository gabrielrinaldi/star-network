# frozen_string_literal: true

class VerifyProfilesJob < ApplicationJob
  queue_as :default

  def perform
    users = User.where(verified_at: nil).all

    users.each do |user|
      VerifyProfileJob.set(queue: :low).perform_later(user:)
    end
  end
end
