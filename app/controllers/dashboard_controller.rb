# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :set_breadcrumbs

  # @route GET / (authenticated_root)
  # @route GET /armory (armory)
  def index; end

  private
    def set_breadcrumbs
      add_breadcrumb(name: 'Dashboard', path: dashboard_path)
    end
end
