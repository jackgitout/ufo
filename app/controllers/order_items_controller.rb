class OrderItemsController < ApplicationController
  def my_cart
    @order_items = OrderItem.all
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @listing = Listing.find(params[:listing_id])
    @order_item.listing = @listing
    @order_item.amount = @order_item.quantity * @order_item.listing.unit_price
    @order_item.user = current_user
    if @order_item.save
      redirect_to my_cart_path
    else
      render :new
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :user_id)
  end
end
