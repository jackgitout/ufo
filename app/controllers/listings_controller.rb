class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @listings = Listing.all
  end

  def show
    # using the set_listing
  end

  def mylistings
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.valid?
      @listing.save
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def edit
    # using the set_listing
  end

  def update
    @list.update(listing_params)
    redirect_to listings_path(@listing)
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :category, :unit_price, :quantity, :description, :expiry_date)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
