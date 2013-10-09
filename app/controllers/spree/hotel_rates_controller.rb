class Spree::HotelRatesController < ApplicationController
  before_action :set_spree_hotel_rate, only: [:show, :edit, :update, :destroy]

  # GET /spree/hotel_rates
  def index
    @spree_hotel_rates = Spree::HotelRate.all
  end

  # GET /spree/hotel_rates/1
  def show
  end

  # GET /spree/hotel_rates/new
  def new
    @spree_hotel_rate = Spree::HotelRate.new
  end

  # GET /spree/hotel_rates/1/edit
  def edit
  end

  # POST /spree/hotel_rates
  def create
    @spree_hotel_rate = Spree::HotelRate.new(spree_hotel_rate_params)

    if @spree_hotel_rate.save
      redirect_to @spree_hotel_rate, notice: 'Hotel rate was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /spree/hotel_rates/1
  def update
    if @spree_hotel_rate.update(spree_hotel_rate_params)
      redirect_to @spree_hotel_rate, notice: 'Hotel rate was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /spree/hotel_rates/1
  def destroy
    @spree_hotel_rate.destroy
    redirect_to spree_hotel_rates_url, notice: 'Hotel rate was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_hotel_rate
      @spree_hotel_rate = Spree::HotelRate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_hotel_rate_params
      params.require(:spree_hotel_rate).permit(:room_id, :init_date, :end_date, :plan_id, :adults_one, :adults_two, :adultd_three, :children_one, :children_two, :adults_extra, :exceptions)
    end
end
