module Spree
  class ProductHotel < ProductAccommodation

    def context_class
      ContextHotel
    end

    def rate_class
      RateHotel
    end

    def combination_class
      CombinationHotel
    end

    def exception_class
      ExceptionHotel
    end

    def calculator_class
      CalculatorHotelDefault
    end

    def generate_combinations
      self.rates.each.map {|r| r.generate_variants}
    end

    def default_property
      # TODO: en el name se puede poner el nombre de la clase y entonces el metodo default_property
      # puede pasar a spree_travel_core
      prototype = Spree::Prototype.find_by_name('Hotel')
      prototype
    end

    def calculate_price(context)
      calculator_class.calculate_price(:product => self, :context => context)
    end
  end
end
