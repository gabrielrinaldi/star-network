# frozen_string_literal: true

module Tokenify
  extend ActiveSupport::Concern

  class_methods do
    def tokenify!(field, opts = {})
      opts[:uniqueness] = { model: to_s.underscore, field: } if opts.delete(:unique)

      after_initialize do |record|
        if record.send(field).blank?
          token = CodeGeneratorService.generate(opts)
          record.send("#{field}=", token)
        end
      end
    end
  end
end
