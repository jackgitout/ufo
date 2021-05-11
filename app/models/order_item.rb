class OrderItem < ApplicationRecord
  belongs_to :listing
  belongs_to :order, optional: true
  belongs_to :user

  validates :quantity, exclusion: { in: [0],
    message: "invalid, no items are added." }
end
