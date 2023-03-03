# frozen_string_literal: true

class BasePresenter < SimpleDelegator
  def initialize(model:, view:)
    super(model)

    @view = view
  end

  def h
    @view
  end
end
