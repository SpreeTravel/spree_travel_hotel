module Spree
  class CalculatorHotel

    def self.calculate_price(params)
      if params[:variant_id]
        object = Spree::Variant.find(params[:variant_id])
      else
        object = Spree::Product.find(params[:product_id])
      end

      return [object.price.to_f] if object.rates.empty?
      pt = object.product_type.name
      return [] if pt != params[:product_type]

      prices = []
      object.rates.each do |r|
        # TODO: los formatos de fecha no son iguales
        if params[pt + '_start_date'].gsub('-', '/') >= r.start_date && params[pt + '_end_date'].gsub('-', '/') <= r.end_date
          # TODO: incluir la multiplicacion por la cantidad de dias
          prices << params[pt + '_adult'].to_i * r.double.to_f
        end
      end
      prices
    end

  end
end
