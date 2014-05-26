module Spree
  class CalculatorHotel

    def self.calculate_variant(params)
      Spree::Variant.variant_from_params(params)
    end

    # TODO: tener en cuenta aqui el maximo de adultos
    def self.get_adult_list(rate, pt_adults)
      if pt_adults.present?
        [pt_adults]
      else
        [1, 2, 3]
      end
    end

    # TODO: tener en cuenta el maximo de ninos y el nino extra
    def self.get_child_list(rate, pt_child)
      if pt_child.present?
        [pt_child]
      else
        [1, 2]
      end
    end

    def self.get_rate_price(rate, adults, children)
      adults = adults.to_i
      children = children.to_i
      adults_hash = {1 => 'simple', 2 => 'double', 3 =>'triple'}
      days = pt_end_date - pt_start_date rescue 1
      price = adults * rate.send(adults_hash[adults]).to_f
      price += rate.first_child.to_f if children >= 1
      price += rate.second_child.to_f if children == 2
      price *= days
      price
    end

    # TODO: obtener objeto contexto con los params
    # TODO: Retornar la variante adem'as del precio
    # TODO: valorar si 'variant' se puede poner como attr opcional para que se calcule dentro
    def self.calculate_price(context, variant)
      product = variant.product
      return [product.price.to_f] if product.rates.empty?
      # pt = product.product_type.name
      # return [] if pt != context[:product_type]
      # TODO: Think about if adults are more than 3
      # TODO: How to manage if a customer just for fuck enter 1.5 adults
      # pt_start_date = params[pt + '_start_date'].to_date if params[pt + '_start_date']
      # pt_end_date = params[pt + '_end_date'].to_date if params[pt + '_end_date']
      # pt_adult = params[pt + '_adult'] #if params[pt + '_adult']
      # pt_child = params[pt + '_child'] #if params[pt + '_child']
      # pt_plan = params[pt + '_plan'].to_i if params[pt + '_plan']
      # pt_variant = self.calculate_variant(params)

      puts "aqui llego"

      prices = []
      # TODO: hacer lo mismo que los adultos y ninos pa los demas campos
      product.rates.each do |r|
        puts "aqui entro"
        next if variant && (variant.id != r.variant_id)
        next if context.start_date && (context.start_date.to_date < r.start_date.to_date)
        next if context.end_date && (context.end_date.to_date > r.end_date.to_date)
        next if context.plan && context.plan.to_i != r.plan.to_i
        puts "ando mas abajo"
        adults_array = self.get_adult_list(r, context.adult)
        children_array = self.get_child_list(r, context.child)
        combinations = adults_array.product(children_array)
        combinations.each do |ad, ch|
          puts "estoy metiendo precios"
          prices << self.get_rate_price(r, ad, ch)
        end

      end
      prices
    end

  end
end
