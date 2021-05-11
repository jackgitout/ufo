class OrderItem < ApplicationRecord
  belongs_to :listing
  belongs_to :order
  belongs_to :user
end
