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
      price = adults * rate.send(adults_hash[adults]).to_f
      price += rate.first_child.to_f if children >= 1
      price += rate.second_child.to_f if children == 2
      price
    end

    # TODO: Retornar la variante adem'as del precio
    # TODO: valorar si 'variant' se puede poner como attr opcional para que se calcule dentro
    def self.calculate_price(context, variant)

      product = variant.product
      return [product.price.to_f] if product.rates.empty?
      prices = []
      days = context.end_date.to_date - context.start_date.to_date rescue 1

      # TODO: hacer lo mismo que los adultos y ninos pa los demas campos
      product.rates.each do |r|
        next if variant && (variant.id != r.variant_id)
        next if context.start_date && (context.start_date.to_date < r.start_date.to_date rescue false)
        next if context.end_date && (context.end_date.to_date > r.end_date.to_date rescue false)
        next if context.plan && context.plan.to_i != r.plan.to_i
        adults_array = self.get_adult_list(r, context.adult)
        children_array = self.get_child_list(r, context.child)
        combinations = adults_array.product(children_array)
        combinations.each do |ad, ch|
          prices << self.get_rate_price(r, ad, ch) * days
        end
      end
      prices
    end

  end
end
