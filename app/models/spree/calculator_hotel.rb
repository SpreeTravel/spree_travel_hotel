module Spree
  class CalculatorHotel

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

    def calculate_price(params)
      return [] if self.product_type_id != params[:product_type_id].to_i
      prefix = params[:product_type_name] + '_'
      prices = []
      self.rates.each do |r|
        start_date = r.get_option_value('start_date')
        end_date = r.get_option_value('end_date')
        # TODO: los formatos de fecha no son iguales
        if params[prefix + 'start_date'].gsub('-', '/') >= start_date && params[prefix + 'end_date'].gsub('-', '/') <= end_date
          # TODO: incluir la multiplicacion por la cantidad de dias
          prices << params[prefix + 'adult'].to_i * r.get_option_value('double').to_f
        end
      end
      prices
    end

  end
end
