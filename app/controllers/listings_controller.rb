class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # if params[:search_query]
    #   @listings = Listing.where("title LIKE ?", "%#{params[:search_query].titleize}%")
    # else
    #   @listings = Listing.where('quantity > 0')
    # end

    # if params[:category]
    #   @listings.where(category: params[:category])
    # end
    @listingsall = Listing.all.where('quantity > 0')
    @listings = Listing.by_query(params[:search_query]).by_category(params[:category]).where('quantity > 0')
  end

  def show
    # using the set_listing
    @listingsall = Listing.all
    @order_item = OrderItem.new
  end

  def my_listings
    @listings = Listing.where(user: current_user)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.valid?
      @listing.save
      redirect_to listings_path(@listing)
    else
      render :new
    end
  end

  def edit
    # using the set_listing
  end

  def update
    @listing.user = current_user
    @listing.update(listing_params)
    redirect_to my_listings_path
  end

  def destroy
    @listing.destroy
    redirect_to my_listings_path
  end

  private

  def query_params
    query_params = params[:query]
    query_params ? query_params.permit(:text, :category) : {}
  end

  def listing_params
    params.require(:listing).permit(:title, :category, :unit_price, :quantity, :description, :expiry_date, :photo)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
