# frozen_string_literal: true

ActiveRecord::Encryption.configure(
  primary_key: ENV.fetch('ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY', nil),
  deterministic_key: ENV.fetch('ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY', nil),
  key_derivation_salt: ENV.fetch('ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT', nil)
)
