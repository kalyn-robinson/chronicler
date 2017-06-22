class User < ApplicationRecord
  acts_as_paranoid

  attr_accessor :remember_token
  
  EMAIL_FORMAT = /.+@.+\..+/

  validates :name,  presence: true, 
                    length: { minimum: 3, maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :email, presence: true, 
                    length: { minimum: 5, maximum: 255 },
                    format: EMAIL_FORMAT
  validates :password, presence: true, 
                       length: { minimum: 6 },
                       allow_nil: true
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  has_secure_password

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
