class User < ApplicationRecord
  has_secure_password validations: false
  has_many :trips
  has_many :s3_uploads, as: :attachable
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, presence: true, if: -> { password_confirmation.present? }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  validate :password_confirmation_match
  MAX_BIO_LENGTH = 200
  validates :bio, length: { maximum: MAX_BIO_LENGTH }

  private

  def password_confirmation_match
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:base, "Passwords do not match.")
    end
  end
end
