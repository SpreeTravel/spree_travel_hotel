module Spree
  class ProductHotel < ProductAccommodation

    def context_class
      ContextHotel
    end
  end
end
