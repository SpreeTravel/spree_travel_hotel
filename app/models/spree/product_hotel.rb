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
      self.rates.each do |r|
        r.generate_variants
      end
    end

    def prototype_instance

    end

    def calculate_price(context)
      calculator_class.calculate_price(:product => self, :context => context)
    end
  end
end
