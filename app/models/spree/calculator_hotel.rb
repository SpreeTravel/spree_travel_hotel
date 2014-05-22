module Spree
  class CalculatorHotel

    def self.calculate_variant(params)
      Spree::Variant.variant_from_params(params)
    end

    # TODO: tener en cuenta aqui el maximo de adultos
    def self.get_adult_list(rate, pt_adults)
      if pt_adults != 0
        [pt_adults]
      else
        [1, 2, 3]
      end
    end

    # TODO: tener en cuenta el maximo de ninos y el nino extra
    def self.get_child_list(rate, pt_child)
      if pt_child != 0
        [pt_child]
      else
        [1, 2]
      end
    end

    def self.get_rate_price(rate, adults, children)
      adults_hash = {1 => 'simple', 2 => 'double', 3 =>'triple'}
      puts "================================================"
      puts adults
      puts adults_hash[adults]
      days = pt_end_date - pt_start_date rescue 1
      puts days
      price = adults * rate.send(adults_hash[adults]).to_f
      puts price
      price += rate.first_child.to_f if children >= 1
      puts price
      price += rate.second_child.to_f if children == 2
      puts price
      price *= days
      price
    end

    # TODO: obtener objeto contexto con los params
    # TODO: Retornar la variante adem'as del precio
    def self.calculate_price(params)
      product = Spree::Product.find(params[:product_id])
      return [product.price.to_f] if product.rates.empty?
      pt = product.product_type.name
      return [] if pt != params[:product_type]
      # TODO: Think about if adults are more than 3
      # TODO: How to manage if a customer just for fuck enter 1.5 adults
      pt_start_date = params[pt + '_start_date'].to_date if params[pt + '_start_date']
      pt_end_date = params[pt + '_end_date'].to_date if params[pt + '_end_date']
      pt_adult = params[pt + '_adult'].to_i #if params[pt + '_adult']
      pt_child = params[pt + '_child'].to_i #if params[pt + '_child']
      pt_plan = params[pt + '_plan'].to_i if params[pt + '_plan']
      pt_variant = self.calculate_variant(params)

      prices = []
      # TODO: hacer lo mismo que los adultos y ninos pa los demas campos
      product.rates.each do |r|
        next if pt_variant && (pt_variant.id != r.variant_id)
        next if pt_start_date && (pt_start_date < r.start_date.to_date)
        next if pt_end_date && (pt_end_date > r.end_date.to_date)
        next if pt_plan && pt_plan != r.plan.to_i

        adults_array = self.get_adult_list(r, pt_adult)
        children_array = self.get_child_list(r, pt_child)
        combinations = adults_array.product(children_array)
        combinations.each do |ad, ch|
          prices << self.get_rate_price(r, ad, ch)
        end

      end
      prices
    end

  end
end
