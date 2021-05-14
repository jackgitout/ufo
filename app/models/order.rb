class Order < ApplicationRecord
  has_many :order_items

  def total_amounts
    total = 0
    order_items.each do |item|
      total += item.amount
    end

    total
  end
end
