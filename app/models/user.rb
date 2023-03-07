# frozen_string_literal: true

class User < ApplicationRecord
  include Tokenify

  nilify_blanks

  tokenify!(:verification_token, length: 8, unique: true)

  devise :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable,
         :two_factor_authenticatable, :two_factor_backupable,
         otp_backup_code_length: 10,
         otp_number_of_backup_codes: 10,
         otp_secret_encryption_key: ENV.fetch('OTP_SECRET_KEY', nil)

  serialize :otp_backup_codes, JSON

  attr_accessor :otp_plain_backup_codes

  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }
  validate :password_complexity

  def verified?
    verified_at.present?
  end

  def generate_two_factor_secret_if_missing!
    return unless otp_secret.nil?

    update!(otp_secret: User.generate_otp_secret)
  end

  def enable_two_factor!
    update!(otp_required_for_login: true)
  end

  def disable_two_factor!
    update!(
      otp_required_for_login: false,
      otp_secret: nil,
      otp_backup_codes: nil
    )
  end

  def two_factor_qr_code_uri
    issuer = 'Star Network'
    issuer += " - #{Rails.env.capitalize}" unless Rails.env.production?
    label = [issuer, username].join(':')

    otp_provisioning_uri(label, issuer:)
  end

  def two_factor_backup_codes_generated?
    otp_backup_codes.present?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private
    def password_complexity
      checker = StrongPassword::StrengthChecker.new
      return if password.blank? || checker.is_strong?(password)

      errors.add :password, 'Password is too weak'
    end
end
