class Trip < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true
  validates :user_id, presence: true
  scope :search, ->(query) {where("name ILIKE ?", "%#{query}%") }
  scope :by_date_range, ->(start_date, end_date) {where(start_date: start_date..end_date)}
end
