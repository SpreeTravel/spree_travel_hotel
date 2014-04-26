module Spree
  class CalculatorHotel

    # TODO: obtener objeto contexto con los params
    def self.calculate_price(params)
      product = Spree::Product.find(params[:product_id])
      return [product.price.to_f] if product.rates.empty?
      pt = product.product_type.name
      return [] if pt != params[:product_type]

      adults = {1 => 'simple', 2 => 'double', 3 =>'triple'}
      pt_start_date = params[pt + '_start_date'].to_date if params[pt + '_start_date']
      pt_end_date = params[pt + '_end_date'].to_date if params[pt + '_end_date']
      pt_adult = params[pt + '_adult'].to_i if params[pt + '_adult']
      pt_child = params[pt + '_child'].to_i if params[pt + '_child']
      pt_plan = params[pt + '_plan'].to_i if params[pt + '_plan']
      pt_variant = Spree::Variant.variant_from_params(params)

      prices = []
      product.rates.each do |r|
        next if pt_variant && (pt_variant.id != r.variant_id)
        next if pt_start_date && (pt_start_date < r.start_date.to_date)
        next if pt_end_date && (pt_end_date > r.end_date.to_date)
        next if pt_plan && pt_plan != r.plan.to_i

        price = pt_adult * r.send(adults[pt_adult]).to_f
        price += r.first_child.to_f if [1, 2].include?(pt_child)
        price += r.second_child.to_f if pt_child == 2
        prices << price * (pt_end_date - pt_start_date rescue 1)
      end
      prices
    end

  end
end
