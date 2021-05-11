class Listing < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true
  validates :category, presence: true
  validates :unit_price, presence: true
  validates :quantity, presence: true
  validates :expiry_date, presence: true
end
