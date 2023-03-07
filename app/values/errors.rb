# frozen_string_literal: true

module Errors
  # Token errors
  class ScopeNotSpecifiedError < StandardError; end
  class FieldNotSpecifiedError < StandardError; end
  class FieldNotFoundError < StandardError; end
  class ClassNotFoundError < StandardError; end

  # HTTP errors
  HTTP_OK_CODE = 200

  HTTP_BAD_REQUEST_CODE = 400
  HTTP_UNAUTHORIZED_CODE = 401
  HTTP_FORBIDDEN_CODE = 403
  HTTP_NOT_FOUND_CODE = 404
  HTTP_UNPROCESSABLE_ENTITY_CODE = 429

  APIExceptionError = Class.new(StandardError)
  BadRequestError = Class.new(APIExceptionError)
  UnauthorizedError = Class.new(APIExceptionError)
  ForbiddenError = Class.new(APIExceptionError)
  NotFoundError = Class.new(APIExceptionError)
  UnprocessableEntityError = Class.new(APIExceptionError)
  APIError = Class.new(APIExceptionError)
end
