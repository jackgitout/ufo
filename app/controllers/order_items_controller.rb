class OrderItemsController < ApplicationController
  def my_cart
    @order_items = OrderItems.all
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.save
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :amount, :user_id)
  end
end
