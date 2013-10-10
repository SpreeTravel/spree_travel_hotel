module Spree
  class ProductHotel < ProductAccommodation

    def context_class
      ContextHotel
    end

    def rate_class
      RateHotel
    end
  end
end
