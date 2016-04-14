module TokenProvider
  module_function
  def generate_token(payload)
    payload['exp'] = 24.hours.from_now.to_i # Set expiration to 24 hours.
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
  def decrypted_token(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    end
  end
end
