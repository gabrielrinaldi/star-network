# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout 'errors'

  skip_before_action :authenticate_user!, :update_current

  def not_found
    render status: :not_found
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
