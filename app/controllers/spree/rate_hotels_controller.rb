class Spree::RateHotelsController < ApplicationController
  before_action :set_spree_rate_hotel, only: [:show, :edit, :update, :destroy]

  # GET /spree/rate_hotels
  def index
    @spree_rate_hotels = Spree::RateHotel.all
  end

  # GET /spree/rate_hotels/1
  def show
  end

  # GET /spree/rate_hotels/new
  def new
    @spree_rate_hotel = Spree::RateHotel.new
  end

  # GET /spree/rate_hotels/1/edit
  def edit
  end

  # POST /spree/rate_hotels
  def create
    @spree_rate_hotel = Spree::RateHotel.new(spree_rate_hotel_params)

    if @spree_rate_hotel.save
      redirect_to @spree_rate_hotel, notice: 'Rate hotel was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /spree/rate_hotels/1
  def update
    if @spree_rate_hotel.update(spree_rate_hotel_params)
      redirect_to @spree_rate_hotel, notice: 'Rate hotel was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /spree/rate_hotels/1
  def destroy
    @spree_rate_hotel.destroy
    redirect_to spree_rate_hotels_url, notice: 'Rate hotel was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_rate_hotel
      @spree_rate_hotel = Spree::RateHotel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_rate_hotel_params
      params.require(:spree_rate_hotel).permit(:product_id, :room_id, :init_date, :end_date, :plan_id, :adults_one, :adults_two, :adultd_three, :children_one, :children_two, :adults_extra, :exceptions)
    end
end
