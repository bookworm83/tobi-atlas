class Trip < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true
  validates :user_id, presence: true
  validates :start_date, presence: true
  validate :end_date_after_start_date
  scope :search, ->(query) { where("LOWER(name) LIKE ?", "%#{query.to_s.downcase}%") }
  scope :by_date_range, ->(start_date, end_date) {where(start_date: start_date..end_date)}

  def duration_nights
    end_date - start_date if start_date.present? && end_date.present?
  end

  private

  def end_date_after_start_date
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, "must be after the start date.")
    end
  end
end
