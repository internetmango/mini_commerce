# frozen_string_literal: true

namespace :ops do
  desc 'Remove all expired otp records'
  task remove_expired_otps: [:environment] do
    expired_otps = Otp.expired
    expired_otps.destroy_all
  end
end
