class OrderItem < ApplicationRecord
  belongs_to :listing
  belongs_to :transaction
  belongs_to :user
end
