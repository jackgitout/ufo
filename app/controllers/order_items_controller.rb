class OrderItemsController < ApplicationController

  def my_cart
    @order_items = OrderItems.all
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @listing = Listing.find(params[:listing_id])
    @order_item.listing = @listing
    @order_item.amount = @order_item.quantity * @order_item.listing.unit_price
    if @order_item.save
      redirect_to listing_path(@listing)
    end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :user_id)
  end
end
