# frozen_string_literal: true

class CodeGeneratorService
  LOWER_ALPHA         = ('a'..'z').to_a
  UPPER_ALPHA         = ('A'..'Z').to_a
  NUMERIC             = (0..9).to_a
  ALPHA               = LOWER_ALPHA + UPPER_ALPHA
  LOWER_ALPHA_NUMERIC = LOWER_ALPHA + NUMERIC
  UPPER_ALPHA_NUMERIC = UPPER_ALPHA + NUMERIC
  ALPHA_NUMERIC       = ALPHA + NUMERIC

  attr_accessor :length, :uniqueness, :use_characters, :include_characters, :invalid_characters, :repeat_characters
  attr_writer :model

  def self.generate(opts = {})
    code_generator = CodeGeneratorService.new(opts)
    code_generator.generate_code
  end

  def initialize(opts = {})
    opts = opts.dup.symbolize_keys!

    @length = opts.delete(:length) || 10
    @use_characters = opts.delete(:use_characters) || :alpha_numeric
    @include_characters = opts.delete(:include_characters) || []
    @invalid_characters = opts.delete(:invalid_characters) || []
    @repeat_characters = opts.delete(:repeat_characters) || true
    @uniqueness = opts.delete(:uniqueness)
    @valid_characters = valid_characters

    set_model_and_field! if uniqueness
  end

  def unique?
    @model.send(:where, { @field_name => @code }).empty?
  end

  def random_string
    chars = @valid_characters.dup

    Array.new(@length) do
      if @repeat_characters
        -> { chars.sample }
      else
        -> { chars.delete_at(rand(chars.length)) }
      end.call
    end.join
  end

  def generate_code
    @code = random_string

    # rubocop:disable Style/NestedModifier
    @code = random_string until unique? if generate_unique?
    # rubocop:enable Style/NestedModifier

    @code
  end

  def model
    uniqueness[:model].to_s.classify.constantize
  rescue StandardError
    raise Errors::ClassNotFoundError
  end

  private
    def valid_characters
      all_chars = "CodeGeneratorService::#{@use_characters.upcase}".constantize
      all_chars |= @include_characters unless @include_characters.empty?
      invalid = @invalid_characters

      all_chars - invalid
    end

    def set_model_and_field!
      raise Errors::ScopeNotSpecifiedError if uniqueness[:model].blank?
      raise Errors::FieldNotSpecifiedError if uniqueness[:field].blank?

      @model = model
      @field_name = uniqueness[:field]

      railse Errors::FieldNotFoundError unless @model.column_names.include? @field_name.to_s
    end

    def generate_unique?
      uniqueness.present?
    end
end
