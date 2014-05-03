module Spree
  class CalculatorHotel

    # TODO: obtener objeto contexto con los params
    def self.calculate_price(params)
      product = Spree::Product.find(params[:product_id])
      return [product.price.to_f] if product.rates.empty?
      pt = product.product_type.name
      return [] if pt != params[:product_type]

      prices = []
      pt_start_date = params[pt + '_start_date'].to_date if params[pt + '_start_date']
      pt_end_date = params[pt + '_end_date'].to_date if params[pt + '_end_date']
      pt_adult = params[pt + '_adult'].to_i if params[pt + '_adult']
      pt_child = params[pt + '_child'].to_i if params[pt + '_child']
      pt_plan = params[pt + '_plan'].to_i if params[pt + '_plan']
      pt_variant = Spree::Variant.variant_from_params(params)

      product.rates.each do |r|
        next if pt_variant && (pt_variant.id != r.variant_id)
        next if pt_start_date && (pt_start_date < r.start_date.to_date)
        next if pt_end_date && (pt_end_date > r.end_date.to_date)
        next if pt_plan && pt_plan != r.plan.to_i
        days = pt_end_date - pt_start_date rescue 1
        price = 0
        if pt_adult == 1
            price += pt_adult * r.simple.to_f
        elsif pt_adult == 2
            price += pt_adult * r.double.to_f
        elsif pt_adult == 3
            price += pt_adult * r.triple.to_f
        end
        if pt_child == 1
            price += r.first_child.to_f
        elsif pt_child == 2
            price += r.first_child.to_f + r.second_child.to_f
        end
        prices << price * days
      end
      prices
    end

  end
end
