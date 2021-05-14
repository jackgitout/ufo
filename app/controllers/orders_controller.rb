class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.status = true if params[:order][:order_item_ids].any?
    if @order.save
      params[:order][:order_item_ids].each do |id|
        oi = OrderItem.find(id)
        oi.order = @order
        listing = Listing.find(oi.listing.id)
        listing.quantity = listing.quantity - oi.quantity
        listing.save!
      end
      redirect_to order_path(@order)
    else
      @order_items = params[:order][:order_item_ids].map do |id|
        OrderItem.find(id)
      end
      render 'order_items/my_cart'
    end
  end

  private
  def order_params
    params.require(:order).permit!
  end
end
