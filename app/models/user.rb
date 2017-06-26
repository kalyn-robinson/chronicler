class User < ApplicationRecord
  acts_as_paranoid
  has_many :characters

  attr_accessor :remember_token, :reset_token
  
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
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token), 
                   reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
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
