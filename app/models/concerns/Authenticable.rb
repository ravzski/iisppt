require 'bcrypt'

module Authenticable
  extend ActiveSupport::Concern


  def reset_confirmation_token
    self.confirmation_token = format('%06d', rand(999999))
    self.confirmed_at = nil
  end

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end

  def password=(new_password)
    @password = new_password
    self.encrypted_password = encrypt(@password) if @password.present?
  end

  def valid_password?(password)
    return false if encrypted_password.blank?
    bcrypt   = ::BCrypt::Password.new(encrypted_password)
    password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)
    secure_compare(password, encrypted_password)
  end


  private


  def encrypt(password)
    ::BCrypt::Password.create(password, cost: 10).to_s
  end

  # constant-time comparison algorithm to prevent timing attacks
  def secure_compare(a, b)
    return false if a.blank? || b.blank? || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end

end
