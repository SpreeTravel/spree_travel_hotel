require "spec_helper"

describe Spree::HotelCombinationsController do
  describe "routing" do

    it "routes to #index" do
      get("/spree/hotel_combinations").should route_to("spree/hotel_combinations#index")
    end

    it "routes to #new" do
      get("/spree/hotel_combinations/new").should route_to("spree/hotel_combinations#new")
    end

    it "routes to #show" do
      get("/spree/hotel_combinations/1").should route_to("spree/hotel_combinations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/spree/hotel_combinations/1/edit").should route_to("spree/hotel_combinations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/spree/hotel_combinations").should route_to("spree/hotel_combinations#create")
    end

    it "routes to #update" do
      put("/spree/hotel_combinations/1").should route_to("spree/hotel_combinations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/spree/hotel_combinations/1").should route_to("spree/hotel_combinations#destroy", :id => "1")
    end

  end
end
