module Spree
  class CalculatorHotelDefault < TravelCalculator

    # TODO: calcular bien cada dia en que temporada cae
    def self.calculate_price_pqr(options = {})
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

    def self.calculate_price(params = {})
      variants = Spree::Variant.with_option_values(params)
      return [0.0] unless variants

      prices = variants.map {|v| v.price.to_f}.sort
      if !params[:start_date].blank? && !params[:end_date].blank?
        # TODO: esto no resta bien
        duration = params[:end_date].to_date - params[:start_date].to_date
        prices = prices.map {|p| p * duration}
      end
      prices
    end

  end
end
