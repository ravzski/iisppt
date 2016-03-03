require 'bcrypt'

module Authenticable
  extend ActiveSupport::Concern


  module ClassMethods

    def find_by_valid_token request_details
      obj = User.find(request_details[:user_id])
      return false unless obj.present?
      if obj.access_token == request_details[:access_token]
        obj
      else
        false
      end
    end

    private

    def validate_access_token obj, request_details
      if obj["access_token"] == request_details[:access_token]
        User.new(obj)
      else
        false
      end
    end
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

  def validate_password_presence
    if (new_record? && @password.blank?) || (!@password.nil? && @password.empty?)
      errors.add(:password, "can't be blank")
    end
  end

  def validate_password_length
    if @password.present? && @password.length < 8
      errors.add(:password, 'must be at least 8 characters')
    end
  end

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
