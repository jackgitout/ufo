class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order(order_params)
  end

  private
  def order__params
    params.require(:order).permit(:user_id)
  end
end
