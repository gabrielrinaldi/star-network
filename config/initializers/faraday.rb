# frozen_string_literal: true

ActiveSupport::Notifications.subscribe('request.faraday') do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  url = event.payload[:url]
  response = event.payload[:response]
  http_method = event.payload[:method].to_s.upcase
  log_prefix = event.name.split('.').last.camelize

  output = format('%<host>s %<method>s %<uri>s', host: url.host,
                                                 method: http_method, uri: url.request_uri)

  output.prepend("[#{log_prefix}] ")
  output.concat(" - #{response.status} (Duration: #{event.duration}ms)")

  Rails.logger.info(output)
end
