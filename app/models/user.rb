# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  admin                  :boolean          default(FALSE), not null
#  citizen_id             :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  consumed_timestep      :integer
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  id                     :uuid             not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  otp_backup_codes       :string           is an Array
#  otp_required_for_login :boolean
#  otp_secret             :string
#  presence               :integer          default("offline"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  thumbnail              :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  updated_at             :datetime         not null
#  username               :citext           not null
#  verification_token     :string
#  verified_at            :datetime
#
class User < ApplicationRecord
  include Tokenify

  nilify_blanks

  tokenify!(:verification_token, length: 8, unique: true)

  enum :presence, { offline: 0, online: 1, away: 2, busy: 3 }

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

  after_update_commit lambda {
                        broadcast_replace_to 'avatars', partial: 'users/avatar', locals: { user: self },
                                                        target: "navigation_user_#{id}"
                      }

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
