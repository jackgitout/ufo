class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    raise
  end

  private
  def order_params
    params.require(:order).permit(:user_id)
  end
end
