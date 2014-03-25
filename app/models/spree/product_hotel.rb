module Spree
  class ProductHotel < ProductAccommodation

    def context_class
      ContextHotel
    end

    def rate_class
      RateHotel
    end

    def exception_class
      ExceptionHotel
    end

    def calculator_class
      CalculatorHotelDefault
    end

    def generate_variants
      self.rates.map {|r| r.generate_variants}
    end

    def get_option_values_in_exception
      self.exceptions.map {|e| e.get_option_values}
    end

    def calculate_price(context)
      calculator_class.calculate_price(:product => self, :context => context)
    end

    def rooms_options
      self.variants.map{|v| v.option_values.map(&:name).select{|ov| ov.starts_with?('room')}}.flatten.uniq
    end

    def plans_options
      self.variants.map{|v| v.option_values.map(&:name).select{|ov| ov.starts_with?('plan')}}.flatten.uniq
    end

    def base_price
      variants = self.variants.select{|v| v.adults == 2 && v.children == 0}
      if self.rooms.include?('room-standard')
        room = 'room-standard'
      else
        room = self.rooms.first
      end
      variants = variants.select{|v| v.room == room}
      if self.plans.include?('plan-all-inclusive')
        plan = 'plan-all-inclusive'
      else
        plan = 'plan-continental-breakfast'
      end
      variants = variants.select{|v| v.plan == plan}
      variants.order(:start_date).last.price
    end

  end
end
