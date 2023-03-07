# frozen_string_literal: true

class VerifyProfileJob < ApplicationJob
  queue_as :high

  def perform(user:)
    profile_parser_service = ProfileParserService.new

    result = profile_parser_service.profile(user:)

    return unless result[:verified]

    user.update(citizen_id: result[:citizen], verified_at: Time.zone.now, thumbnail: result[:thumbnail])
  end
end
