require "spec_helper"

describe SpreeHotelCombinationsController do
  describe "routing" do

    it "routes to #index" do
      get("/spree_hotel_combinations").should route_to("spree_hotel_combinations#index")
    end

    it "routes to #new" do
      get("/spree_hotel_combinations/new").should route_to("spree_hotel_combinations#new")
    end

    it "routes to #show" do
      get("/spree_hotel_combinations/1").should route_to("spree_hotel_combinations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/spree_hotel_combinations/1/edit").should route_to("spree_hotel_combinations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/spree_hotel_combinations").should route_to("spree_hotel_combinations#create")
    end

    it "routes to #update" do
      put("/spree_hotel_combinations/1").should route_to("spree_hotel_combinations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/spree_hotel_combinations/1").should route_to("spree_hotel_combinations#destroy", :id => "1")
    end

  end
end
