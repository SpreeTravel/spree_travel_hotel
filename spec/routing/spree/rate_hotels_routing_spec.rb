require "spec_helper"

describe Spree::RateHotelsController do
  describe "routing" do

    it "routes to #index" do
      get("/spree/rate_hotels").should route_to("spree/rate_hotels#index")
    end

    it "routes to #new" do
      get("/spree/rate_hotels/new").should route_to("spree/rate_hotels#new")
    end

    it "routes to #show" do
      get("/spree/rate_hotels/1").should route_to("spree/rate_hotels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/spree/rate_hotels/1/edit").should route_to("spree/rate_hotels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/spree/rate_hotels").should route_to("spree/rate_hotels#create")
    end

    it "routes to #update" do
      put("/spree/rate_hotels/1").should route_to("spree/rate_hotels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/spree/rate_hotels/1").should route_to("spree/rate_hotels#destroy", :id => "1")
    end

  end
end
