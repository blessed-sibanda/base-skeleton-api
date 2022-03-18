class User < ApplicationRecord
  before_save { self.email&.downcase! }
  has_secure_password
  validates :name, presence: true
  validates :email, uniqueness: true,
                    presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: "'%{value}' is not a valid email address" }
  validates_length_of :password, within: 6..30, if: :password_required?

  def password_required?
    password_digest.blank? || !password.blank?
  end
end
