class Spree::HotelCombinationsController < ApplicationController
  before_action :set_spree_hotel_combination, only: [:show, :edit, :update, :destroy]

  # GET /spree/hotel_combinations
  def index
    @spree_hotel_combinations = Spree::HotelCombination.all
  end

  # GET /spree/hotel_combinations/1
  def show
  end

  # GET /spree/hotel_combinations/new
  def new
    @spree_hotel_combination = Spree::HotelCombination.new
  end

  # GET /spree/hotel_combinations/1/edit
  def edit
  end

  # POST /spree/hotel_combinations
  def create
    @spree_hotel_combination = Spree::HotelCombination.new(spree_hotel_combination_params)

    if @spree_hotel_combination.save
      redirect_to @spree_hotel_combination, notice: 'Hotel combination was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /spree/hotel_combinations/1
  def update
    if @spree_hotel_combination.update(spree_hotel_combination_params)
      redirect_to @spree_hotel_combination, notice: 'Hotel combination was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /spree/hotel_combinations/1
  def destroy
    @spree_hotel_combination.destroy
    redirect_to spree_hotel_combinations_url, notice: 'Hotel combination was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spree_hotel_combination
      @spree_hotel_combination = Spree::HotelCombination.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spree_hotel_combination_params
      params.require(:spree_hotel_combination).permit(:room_id, :init_date, :end_date, :plan_id, :adults, :children, :price)
    end
end
