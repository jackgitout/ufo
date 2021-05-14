class Order < ApplicationRecord
  has_many :order_items 

  # validates :total, numericality: { greater_than: 0, message: "Opps, there are nothing in your transaction." }

  def total_amounts
    total = 0
    order_items.each do |item|
      total += item.amount
    end

    total
  end
end
