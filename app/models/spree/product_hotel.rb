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
      self.rates.map {|r| r.generate_variants}
    end

    def get_option_values_in_exception
      self.exceptions.map {|e| e.get_option_values}
    end

    def default_prototype
      # TODO: pasar este metodo para la clase Product
      # TODO: asignar este valor cuando se crea un nuevo producto
      prototype = Spree::Prototype.find_by_name('Hotel')
      prototype
    end

    def calculate_price(context)
      calculator_class.calculate_price(:product => self, :context => context)
    end

    def rooms
      self.variants.map{|v| v.option_values.map(&:name).select{|ov| ov.starts_with?('room')}}.uniq
    end

  end
end
