# frozen_string_literal: true

require 'httpx/adapters/faraday'
require 'faraday'

class ProfileParserService
  include Errors

  PROFILE_ENDPOINT = 'https://robertsspaceindustries.com'

  def profile(user:)
    html = request(
      http_method: :get,
      endpoint: "citizens/#{user.username}"
    )

    doc = Nokogiri::HTML(html)

    {
      citizen: citizen(doc:),
      thumbnail: thumbnail(doc:),
      verified: verified(doc:, user:)
    }
  end

  private
    def client
      @client ||= Faraday.new(PROFILE_ENDPOINT) do |client|
        client.adapter :httpx
        client.request :instrumentation
      end
    end

    def request(http_method:, endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params)

      return response.body if response_successful?(response)

      raise error_class(response), "Code: #{response.status}, response: #{response.body}"
    end

    # rubocop:disable Metrics/MethodLength
    def error_class(response)
      case response.status
      when HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HTTP_UNAUTHORIZED_CODE
        UnauthorizedError
      when HTTP_FORBIDDEN_CODE
        ForbiddenError
      when HTTP_NOT_FOUND_CODE
        NotFoundError
      when HTTP_UNPROCESSABLE_ENTITY_CODE
        UnprocessableEntityError
      else
        APIError
      end
    end
    # rubocop:enable Metrics/MethodLength

    def response_successful?(response)
      response.status == HTTP_OK_CODE
    end

    def citizen(doc:)
      doc.xpath('/html/body/div[2]/div[2]/div[2]/div/div/div[2]/p/strong').text
    end

    def thumbnail(doc:)
      path = doc.xpath('/html/body/div[2]/div[2]/div[2]/div/div/div[2]/div[1]/div/div[1]/div/div[1]/img')
                .attribute('src').value

      path = "#{PROFILE_ENDPOINT}#{path}" unless path.include? 'http'

      path
    end

    def verified(doc:, user:)
      bio = doc.xpath('/html/body/div[2]/div[2]/div[2]/div/div/div[2]/div[3]/div/div/div').text

      bio.include? user.verification_token
    end
end
