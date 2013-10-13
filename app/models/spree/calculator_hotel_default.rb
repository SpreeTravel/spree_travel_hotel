module Spree
  class CalculatorHotelDefault < TravelCalculator

    def self.calculate_price(options = {})
      product = options[:product]
      context = options[:context]
      combinations = product.combinations
      combinations = combinations.where(:plan_id => context[:plan_id]) if context[:plan_id]
      combinations = combinations.where(:init_date => context[:init_date]) if context[:init_date]
      combinations = combinations.where(:end_date => context[:end_date]) if context[:end_date]
      combinations = combinations.where(:adults => context[:adults]) if context[:adults]
      combinations = combinations.where(:children => context[:children]) if context[:children]
      prices = combinations.pluck(:price).sort
      prices
    end
  end
end
