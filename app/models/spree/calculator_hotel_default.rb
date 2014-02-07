module Spree
  class CalculatorHotelDefault < TravelCalculator

    # TODO: calcular bien cada dia en que temporada cae
    def self.calculate_price(options = {})
      product = options[:product]
      context = options[:context]
      variants   = product.variants
      variants   = variants.where(:room_id => context[:room_id]) if context[:room_id]
      variants   = variants.where(:plan_id => context[:plan_id]) if context[:plan_id]
      variants   = variants.where(:adults => context[:adults]) if context[:adults]
      variants   = variants.where(:children => context[:children]) if context[:children]
      if context[:start_date] && context[:end_date]
        variants = variants.where('start_date <= ?', context[:start_date]) if context[:start_date]
        variants = variants.where('end_date >= ?', context[:start_date]) if context[:start_date]
        duration = context[:end_date] - context[:start_date] + 1
      else
        duration = nil
      end
      prices = variants.pluck(:price).sort
      prices = prices.map {|p| p * duration } if duration
      prices
    end
  end
end
