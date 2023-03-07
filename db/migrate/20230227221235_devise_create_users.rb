# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext'

    # rubocop:disable Metrics/BlockLength
    create_table :users, id: :uuid do |t|
      ## Database authenticatable
      t.citext :email, null: false, default: '', index: { unique: true }
      t.string :encrypted_password, null: false, default: ''

      ## Two factor authentication
      t.string :otp_secret
      t.integer :consumed_timestep
      t.boolean :otp_required_for_login
      t.string :otp_backup_codes, array: true

      ## Extra fields
      t.citext :username, null: false, index: { unique: true }

      ## Recoverable
      t.string :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Verifiable
      t.string :citizen_id
      t.string :thumbnail
      t.string :verification_token, index: { unique: true }
      t.datetime :verified_at, index: true

      # Confirmable
      t.string :confirmation_token, index: { unique: true }
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email

      # Lockable
      t.integer :failed_attempts, default: 0, null: false
      t.string :unlock_token, index: { unique: true }
      t.datetime :locked_at

      ## Admin
      t.boolean :admin, default: false, null: false

      t.timestamps null: false
    end
    # rubocop:enable Metrics/BlockLength
  end
end
