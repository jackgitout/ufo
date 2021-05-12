class Listing < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true
  validates :category, presence: true
  validates :unit_price, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :expiry_date, presence: true

  scope :by_query, ->(query) do
    where("title LIKE ?", "%#{query.titleize}%") if query.present?
  end

  scope :by_category, ->(category) do
    where(category: category) if category.present?
  end
end
