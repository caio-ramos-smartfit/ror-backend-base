Devise.setup do |config|
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.secret_key_base || 'development_jwt_secret'
    jwt.dispatch_requests = [
      ['POST', %r{^/api/v1/auth/sign_in$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/api/v1/auth/sign_out$}]
    ]
    jwt.expiration_time = 1.day.to_i
  end
end
