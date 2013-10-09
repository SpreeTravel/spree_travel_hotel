require "spec_helper"

describe SpreeHotelRatesController do
  describe "routing" do

    it "routes to #index" do
      get("/spree_hotel_rates").should route_to("spree_hotel_rates#index")
    end

    it "routes to #new" do
      get("/spree_hotel_rates/new").should route_to("spree_hotel_rates#new")
    end

    it "routes to #show" do
      get("/spree_hotel_rates/1").should route_to("spree_hotel_rates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/spree_hotel_rates/1/edit").should route_to("spree_hotel_rates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/spree_hotel_rates").should route_to("spree_hotel_rates#create")
    end

    it "routes to #update" do
      put("/spree_hotel_rates/1").should route_to("spree_hotel_rates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/spree_hotel_rates/1").should route_to("spree_hotel_rates#destroy", :id => "1")
    end

  end
end
