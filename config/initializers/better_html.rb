# frozen_string_literal: true

BetterHtml.configure do |config|
  config.partial_attribute_name_pattern = /\A[a-zA-Z0-9\-:@.]+\z/
  config.template_exclusion_filter = proc do |filename|
    filename.include?('mailers')
  end
end
