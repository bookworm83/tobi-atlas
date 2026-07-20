class User < ApplicationRecord
  has_secure_password validations: false
  has_many :trips
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validate :password_confirmation_match

  private

  def password_confirmation_match
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:base, "Passwords do not match.")
    end
  end
end
