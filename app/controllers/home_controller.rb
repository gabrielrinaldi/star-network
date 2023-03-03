# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  skip_before_action :authenticate_user!, :update_current

  # @route GET /home (home)
  # @route GET / (root)
  def index; end
end
