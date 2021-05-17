class OrderItemsController < ApplicationController
  before_action :find_listing, only: [:create]

  def my_cart
    @order_items = OrderItem.where(order: [nil, false])
    @order = Order.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    # if the user already has this order item,
    # add the amount in the params to the the order item
    # otherwise, create a new order item
    @order_item.listing = @listing
    @order_item.amount = @order_item.quantity * @order_item.listing.unit_price
    @order_item.user = current_user
    if @order_item.save
      redirect_to listing_path(@listing)
    else
      @user = User.find(@listing.user_id)
      render 'listings/show'
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to my_cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :user_id)
  end

  def find_listing
    @listing = Listing.find(params[:listing_id])
  end

end

