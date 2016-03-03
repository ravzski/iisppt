class User < ActiveRecord::Base
  include Authenticable
  include TokenProcessor
  include Searchable
  
  validates :email, presence: true,  uniqueness: true
  after_create :set_access_token

  #
  # Returns the user's full name
  #
  def full_name
    "#{first_name} #{last_name}"
  end

  #
  # Finds a user given email and password
  # note: valid password method is inside authenticable
  #
  def self.find_by_credentials(creds)
    return nil unless creds.present?
    user = self.find_by_email(creds[:email])
    user if user.present? && user.valid_password?(creds[:password])
  end

end
