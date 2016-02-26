class User < ActiveRecord::Base
  include Authenticable

  validates :email, presence: true,  uniqueness: true
  #validate :validate_password_presence
  #validate :validate_password_length

  before_save :ensure_authentication_token
  has_many :likes
  has_many :reminders

  def ensure_authentication_token
    if auth_token.blank?
      self.auth_token = generate_authentication_token
    end
  end

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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end

  def destroy_access_token
    self.update(access_token: nil)
  end


end
