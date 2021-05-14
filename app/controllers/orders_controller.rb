class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.status = true if (validate_order_status(params) == true)
    if  @order.status == true && @order.save
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
      flash.now[:notice] = "We dont have that much available"
      render 'order_items/my_cart'
    end
  end

  private
  def order_params
    params.require(:order).permit!
  end

  def validate_order_status(params)
    status = false
    
    # iterate through order_ids and groups order_ids that have the same listing_id
    oi = params[:order][:order_item_ids].map do |id|
      id.to_i
    end

    # show orderitems with listings by orderitem_id
    order_items = OrderItem.joins(:listing).where(id: oi)
    # group order_items by listing_id
    grouped = order_items.group_by { |el| el.listing_id }
    # grouped returns a key and value. key = listing_id value = order_item
    # iterates through grouped hash and generate an array of listing_id with summed quantity
    grouped_quantity = grouped.map do |listing_id, order_arr| 
      [listing_id, order_arr.sum(&:quantity)] 
    end
    grouped_quantity.each do |arr|
      listing_original_quantity = Listing.find(arr[0]).quantity
      purchase_quantity = arr[1]
      if purchase_quantity <= listing_original_quantity
        status = true
      else
        status = false
      end    
    end  
    return status
  end
end
