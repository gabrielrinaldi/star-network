# frozen_string_literal: true

module Errors
  class ScopeNotSpecifiedError < StandardError; end
  class FieldNotSpecifiedError < StandardError; end
  class FieldNotFoundError < StandardError; end
  class ClassNotFoundError < StandardError; end
end
