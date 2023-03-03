# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def promote?
    @user.admin?
  end

  def demote?
    @user.admin?
  end

  def destroy?
    admin_or_current?
  end

  def update?
    admin_or_current?
  end

  def permitted_attributes
    if @user.admin?
      %i[username email admin verified_at]
    else
      %i[email]
    end
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      else
        scope.where(id: @user.id)
      end
    end
  end

  private
    def admin_or_current?
      @user.admin? or @user == @record
    end
end
