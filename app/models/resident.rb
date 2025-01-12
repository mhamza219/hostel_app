require 'jwt'

class Resident < ApplicationRecord

  has_secure_password

  has_many :bookings

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  # Validate password and return JWT token if valid
  def self.validate_password(email, password)
    byebug
    resident = Resident.find_by(email: email)
    
    if resident&.authenticate(password)
      token = generate_token(resident.id)
      { token: token, message: 'Login successful' }
    else
      { error: 'Invalid email or password' }
    end
  end

  # Generate JWT token
  def self.generate_token(resident_id)
    payload = { resident_id: resident_id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # Decode JWT token
  def self.decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    decoded[0]['resident_id']
  rescue JWT::DecodeError
    nil
  end
end
