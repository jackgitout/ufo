class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      params[:order][:order_item_ids].each do |id|
        oi = OrderItem.find(id)
        oi.order = @order
        oi.save!
      end
    end
      redirect_to order_path(@order)

  end

  private
  def order_params
    params.require(:order).permit(:user_id)
  end
end
