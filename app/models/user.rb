class User < ApplicationRecord
  EMAIL_FORMAT = /.+@.+\..+/

  validates :name,  presence: true, 
                    length: { minimum: 3, maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :email, presence: true, 
                    length: { minimum: 5, maximum: 255 },
                    format: EMAIL_FORMAT
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end
