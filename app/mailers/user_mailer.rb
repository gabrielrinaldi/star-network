# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def delete
    @user = params[:user]
    mail(to: @user.email, subject: 'Account deleted')
  end
end
