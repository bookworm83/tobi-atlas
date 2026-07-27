class User < ApplicationRecord
  has_secure_password validations: false
  has_many :trips
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, if: -> { password.present? }
  validate :password_confirmation_match
  validates :bio, length: { maximum: 200 }

  private

  def password_confirmation_match
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:base, "Passwords do not match.")
    end
  end
end
