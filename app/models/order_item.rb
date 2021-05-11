class OrderItem < ApplicationRecord
  belongs_to :listing
  belongs_to :order, optional: true
  belongs_to :user
end
