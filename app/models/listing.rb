class Listing < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one_attached :photo

  validates :title, presence: true
  validates :category, presence: true
  validates :unit_price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: -1, message: "There are insufficient quantity, please try again" }
  validates :expiry_date, presence: true

  scope :by_query, ->(query) do
    where("title LIKE ?", "%#{query.titleize}%") if query.present?
  end

  scope :by_category, ->(category) do
    where(category: category) if category.present?
  end
end
